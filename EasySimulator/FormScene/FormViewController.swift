//
//  FormViewController.swift
//  Easy Simulator
//

import UIKit

enum KeyboardState {
    case hidden
    case displayed
}

class FormViewController: UIViewController {
    fileprivate let formView = FormView()
    fileprivate var keyboardState: KeyboardState = .hidden
    fileprivate var apiService: FormAPI?
    weak var coordinatorDelegate: AppCoordinatorDelegate?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(service: FormAPI) {
        self.init(nibName: nil, bundle: nil)
        self.apiService = service
    }
}

// MARK: - Lifecycle

extension FormViewController {
    override func loadView() {
        self.view = formView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupView()
    }
}

// MARK: - Setup

extension FormViewController {
    func setupNavigation() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func setupView() {
        formView.setTextfieldsDelegate(self)
        formView.buttonAction = simulateButtonPressed
    }
}

// MARK: - Gestures

extension FormViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        formView.endEditing(true)
    }
}

// MARK: - Textfields

extension FormViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        applyOffsetToView(for: textField.tag)
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            let datePickerView: UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePicker.Mode.date
            textField.inputView = datePickerView
            datePickerView.addTarget(self,
                                     action: #selector(datePickerValueChanged(sender:)),
                                     for: UIControl.Event.valueChanged)
        }
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        applyOffsetToView(for: textField.tag)
        return true
    }

    func applyOffsetToView(for textfieldTag: Int) {
        let offset = self.formView.offsetForRateKeyboard(textfieldTag)
        guard offset != 0 else { return }

        UIView.animate(withDuration: 0.25) {
            switch self.keyboardState {
            case .hidden:
                self.view.frame.origin.y -= offset
                self.keyboardState = .displayed
            case .displayed:
                self.view.frame.origin.y += offset
                self.keyboardState = .hidden
            }
        }
    }
}

// MARK: - Date Picker

extension FormViewController {
    @objc
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        formView.setDateText(dateFormatter.string(from: sender.date))
    }
}

// MARK: - Alert

extension FormViewController {
    enum AlertType {
        case emptyFields
        case responseError
    }

    func showAlert(type: AlertType) {
        let title = "Erro"
        var message = "Por favor, preencha todos os campos."

        if type == .responseError {
            message = "Não foi possível completar a solicitação. Por favor tente novamente."
        }

        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertAction.accessibilityLabel = "OkAlertAction"
        alertController.addAction(alertAction)

        present(alertController, animated: true) {}
    }
}

// MARK: - Button action

extension FormViewController {
    func simulateButtonPressed() {
        guard
            let amount = formView.getAmount(),
            let date = formView.getMaturityDate(),
            let rate = formView.getRate()
            else {
                showAlert(type: .emptyFields)
                return
        }

        let loadingView = self.startLoading(text: "Carregando")

        let model = FormModel(investedAmount: amount, index: "CDI", rate: rate, isTaxFree: false, maturityDate: date)
        apiService?.getSimulationResult(model: model) { [unowned self] result in
            self.stopLoading(loadingView)

            switch result {
            case .success (let response):
                let roundedResponse = response.roundValues()
                DispatchQueue.main.async {
                    self.coordinatorDelegate?.simulationDidFinish(with: roundedResponse)
                }
            case .error:
                DispatchQueue.main.async {
                    self.showAlert(type: .responseError)
                }
            }
        }
    }
}
