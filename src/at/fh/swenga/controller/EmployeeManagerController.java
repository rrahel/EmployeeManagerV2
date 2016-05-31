package at.fh.swenga.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import at.fh.swenga.model.EmployeeManager;
import at.fh.swenga.model.EmployeeModel;

@Controller
public class EmployeeManagerController {

    @Autowired
    private EmployeeManager employeeManager;
//only called once -> helping spring with more information
    @InitBinder
    public void initBinder(WebDataBinder binder) {
	SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
	dateFormat.setLenient(false);
	binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
    }
// if site is requested by the root or listEmployees
//put it into a model and call "listEmployees"
    @RequestMapping(value = { "/", "listEmployees" })
    public String showAllEmployees(Model model) {
	model.addAttribute("employees", employeeManager.getAllEmployees());
	return "listEmployees";
    }

    // Another version of showAllEmployees()
    public ModelAndView showAllEmployeesV2() {
	ModelAndView mav = new ModelAndView();
	mav.addObject("employees", employeeManager.getAllEmployees());
	mav.setViewName("listEmployees");
	return mav;
    }

    // Another version of showAllEmployees()
    public ModelAndView showAllEmployeesV3() {
	ModelAndView mav = new ModelAndView("listEmployees", "employees", employeeManager.getAllEmployees());
	return mav;
    }
//every searchEmployee request -> take the model and put the parameter for the search into it
    @RequestMapping("/searchEmployees")
    public String search(Model model, @RequestParam String searchString) {
	model.addAttribute("employees", employeeManager.getFilteredEmployees(searchString));
	return "listEmployees";
    }
//every deleteEmployee request -> delete the Person with the ssn and give feedback if it was successful
    @RequestMapping("/deleteEmployee")
    public String delete(Model model, @RequestParam int ssn) {
	boolean isRemoved = employeeManager.remove(ssn);

	if (isRemoved) {
	    model.addAttribute("warningMessage", "Employee " + ssn + " deleted");
	} else {
	    model.addAttribute("errorMessage", "There is no Employee " + ssn);
	}

	// Multiple ways to "forward" to another Method
	// return "forward:/listEmployees";
	return showAllEmployees(model);
    }
//fill the list with data
    @RequestMapping("/fillEmployeeList")
    public String fillEmployeeList() {

	Date now = new Date();
	employeeManager.addEmployee(employeeManager.createEmployeeModel(1, "Max", "Mustermann", now));
	employeeManager.addEmployee(employeeManager.createEmployeeModel(2, "Mario", "Rossi", now));
	employeeManager.addEmployee(employeeManager.createEmployeeModel(3, "John", "Doe", now));
	employeeManager.addEmployee(employeeManager.createEmployeeModel(4, "Jane", "Doe", now));
	employeeManager.addEmployee(employeeManager.createEmployeeModel(5, "Maria", "Noname", now));
	employeeManager.addEmployee(employeeManager.createEmployeeModel(6, "Josef", "Noname", now));

	return "forward:/listEmployees";
    }
//a method is needed to get to the jsp file
    @RequestMapping(value = "/addEmployee", method = RequestMethod.GET)
    public String showAddEmployeeForm(Model model) {
	// model.addAttribute("employee",
	// employeeManager.createEmployeeModel());
	return "editEmployee";
    }

    @RequestMapping(value = "/addEmployee", method = RequestMethod.POST)
    public String addEmployee(@Valid @ModelAttribute EmployeeModel newEmployeeModel, BindingResult bindingResult,
	    Model model) {

	if (bindingResult.hasErrors()) {
	    String errorMessage = "";
	    for (FieldError fieldError : bindingResult.getFieldErrors()) {
		errorMessage += fieldError.getField() + " is invalid<br>";
	    }
	    model.addAttribute("errorMessage", errorMessage);
	    return "forward:/listEmployees";
	}

	EmployeeModel employee = employeeManager.getEmployeeBySSN(newEmployeeModel.getSsn());

	if (employee != null) {
	    model.addAttribute("errorMessage", "Employee already exists!<br>");
	} else {
	    employeeManager.addEmployee(newEmployeeModel);
	    model.addAttribute("message", "New employee " + newEmployeeModel.getSsn() + " added.");
	}

	return "forward:/listEmployees";
    }

    @RequestMapping(value = "/changeEmployee", method = RequestMethod.GET)
    public String showChangeEmployeeForm(Model model, @RequestParam int ssn) {
	EmployeeModel employee = employeeManager.getEmployeeBySSN(ssn);
	if (employee != null) {
	    model.addAttribute("employee", employee);
	    return "editEmployee";
	} else {
	    model.addAttribute("errorMessage", "Couldn't find employee " + ssn);
	    return "forward:/listEmployees";
	}
    }

    @RequestMapping(value = "/changeEmployee", method = RequestMethod.POST)
    public String changeEmployee(@Valid @ModelAttribute EmployeeModel changedEmployeeModel,
	    BindingResult bindingResult, Model model) {

	if (bindingResult.hasErrors()) {
	    String errorMessage = "";
	    for (FieldError fieldError : bindingResult.getFieldErrors()) {
		errorMessage += fieldError.getField() + " is invalid<br>";
	    }
	    model.addAttribute("errorMessage", errorMessage);
	    return "forward:/listEmployees";
	}

	EmployeeModel employee = employeeManager.getEmployeeBySSN(changedEmployeeModel.getSsn());

	if (employee == null) {
	    model.addAttribute("errorMessage", "Employee does not exist!<br>");
	} else {
	    employee.setSsn(changedEmployeeModel.getSsn());
	    employee.setFirstName(changedEmployeeModel.getFirstName());
	    employee.setLastName(changedEmployeeModel.getLastName());
	    employee.setDayOfBirth(changedEmployeeModel.getDayOfBirth());
	    model.addAttribute("message", "Changed employee " + changedEmployeeModel.getSsn());
	}

	return "forward:/listEmployees";
    }

    @ExceptionHandler(Exception.class)
    public String handleAllException(Exception ex) {

	return "showError";

    }

}
