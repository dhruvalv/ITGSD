package itgsd.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import itgsd.model.ChangePassForm;
import itgsd.model.Ticket;
import itgsd.model.Unit;
import itgsd.model.User;
import itgsd.model.dao.TicketDao;
import itgsd.model.dao.UnitDao;
import itgsd.model.dao.UserDao;

@Controller
public class UserController {

	@Autowired
	private UserDao userDao;

	@Autowired
	private TicketDao ticketDao;

	@Autowired
	private UnitDao unitDao;

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String welcome(HttpServletRequest request, Map<String, Object> model) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loggedInUser");
		System.out.print("user"+ user);
		if (user != null) {
		
			List<Unit> units = unitDao.getUnits();

			model.put("units", units);
			model.put("user", user);

			if (user.getType().equals(User.Type.REGULAR)) {
				List<Ticket> tickets = ticketDao.getTicketsCreatedBy(user);
				model.put("tickets", tickets);
				return "homepage";
			}

			if (user.getType().equals(User.Type.SUPERVISOR)) {
				List<Ticket> tickets = ticketDao.getTicketsAssignedTo(user.getUnit());
				model.put("tickets", tickets);
				return "shomepage";
			}

			if (user.getType().equals(User.Type.TECHNICIAN)) {
				List<Ticket> tickets = ticketDao.getTicketsAssignedTo(user);
				model.put("tickets", tickets);
				return "thomepage";
			}

			List<User> userList = userDao.getUsers();
			model.put("userList", userList);
			List<Ticket> tickets = ticketDao.getTickets();
			model.put("tickets", tickets);
			return "ahomepage";
		}

		return "login";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@ModelAttribute("userForm") User userForm, HttpServletRequest request,
			Map<String, Object> model) {
		System.out.println("inside login");
		String username = userForm.getUsername();
		String password = userForm.getPassword();

		User user = userDao.getUser(username);
		if (null == user) {
			model.put("usernameError", "Username doesnot exist");
			return "login";
		}

		System.out.println("password:" + password);
		System.out.println("user.getHash()" + user.getHash());
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		boolean flag = passwordEncoder.matches(password, user.getHash());
		if (!flag) {
			model.put("passwordError", "Invalid Password");
			return "login";
		}

		HttpSession session = request.getSession();
		session.setAttribute("loggedInUser", user);
		List<Unit> units = unitDao.getUnits();

		model.put("units", units);
		model.put("user", user);

		if (user.getType().equals(User.Type.REGULAR)) {
			List<Ticket> tickets = ticketDao.getTicketsCreatedBy(user);
			model.put("tickets", tickets);
			return "homepage";
		}

		if (user.getType().equals(User.Type.SUPERVISOR)) {
			List<Ticket> tickets = ticketDao.getTicketsAssignedTo(user.getUnit());
			model.put("tickets", tickets);
			return "shomepage";
		}

		if (user.getType().equals(User.Type.TECHNICIAN)) {
			List<Ticket> tickets = ticketDao.getTicketsAssignedTo(user);
			model.put("tickets", tickets);
			return "thomepage";
		}

		List<User> userList = userDao.getUsers();
		model.put("userList", userList);
		List<Ticket> tickets = ticketDao.getTickets();
		model.put("tickets", tickets);
		return "ahomepage";
	}

	@RequestMapping(value = "/updateProfile", method = RequestMethod.POST)
	public String updateProfile(@ModelAttribute("updateProfileForm") User updateProfile, HttpServletRequest request,
			Map<String, Object> model) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loggedInUser");
		user.setFirstName(updateProfile.getFirstName());
		user.setLastName(updateProfile.getLastName());
		user.setEmail(updateProfile.getEmail());
		user.setPhone(updateProfile.getPhone());
		user = userDao.saveUser(user);
		List<Unit> units = unitDao.getUnits();
		model.put("user", user);
		model.put("units", units);
		model.put("profileUpdated", true);

		if (user.getType().equals(User.Type.REGULAR)) {
			List<Ticket> tickets = ticketDao.getTicketsCreatedBy(user);
			model.put("tickets", tickets);
			return "homepage";
		} else if (user.getType().equals(User.Type.SUPERVISOR)) {
			List<Ticket> tickets = ticketDao.getTicketsAssignedTo(user.getUnit());
			model.put("tickets", tickets);
			return "shomepage";
		} else if (user.getType().equals(User.Type.TECHNICIAN)) {
			List<Ticket> tickets = ticketDao.getTicketsAssignedTo(user);
			model.put("tickets", tickets);
			return "thomepage";
		}

		List<User> userList = userDao.getUsers();
		model.put("userList", userList);
		List<Ticket> tickets = ticketDao.getTickets();
		model.put("tickets", tickets);
		return "ahomepage";

	}

	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String singup(HttpServletRequest request, Map<String, Object> model) {
		User user = new User();
		user.setFirstName(request.getParameter("firstName"));
		user.setLastName(request.getParameter("lastName"));
		user.setEmail(request.getParameter("email"));
		user.setUsername(request.getParameter("username"));
		user.setPhone(request.getParameter("phone"));
		user.setType(User.Type.REGULAR);
		String password = request.getParameter("password");
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		user.setHash(passwordEncoder.encode(password));
		user = userDao.saveUser(user);
		HttpSession session = request.getSession();
		session.setAttribute("loggedInUser", user);
		List<Ticket> tickets = ticketDao.getTicketsCreatedBy(user);
		List<Unit> units = unitDao.getUnits();
		model.put("user", user);
		model.put("tickets", tickets);
		model.put("units", units);
		model.put("profileCreated", true);

		return "homepage";
	}

	@RequestMapping(value = "/assignRole", method = RequestMethod.POST)
	public String assignRole(HttpServletRequest request, Map<String, Object> model) {
		User userToBeAssigned = userDao.getUser(Long.parseLong(request.getParameter("user")));
		String role = request.getParameter("role");
		System.out.println("<><>" + role);
		long unitId = Long.parseLong(request.getParameter("unit"));

		Unit unit = unitDao.getUnit(unitId);
		userToBeAssigned.setUnit(unit);

		if (role.equals("REGULAR")) {
			userToBeAssigned.setType(User.Type.REGULAR);
			userToBeAssigned.setUnit(null);
		} else if (role.equals("TECHNICIAN")) {
			userToBeAssigned.setType(User.Type.TECHNICIAN);
			List<User> technicians = unit.getTechnicians();
			technicians.add(userToBeAssigned);
			unit.setTechnicians(technicians);
		} else if (role.equals("SUPERVISOR")) {
			userToBeAssigned.setType(User.Type.SUPERVISOR);
			List<User> supervisors = unit.getSupervisors();
			supervisors.add(userToBeAssigned);
			unit.setSupervisors(supervisors);
		} else if (role.equals("ADMIN")) {
			userToBeAssigned.setType(User.Type.ADMIN);
		}

		userDao.saveUser(userToBeAssigned);
		unitDao.saveUnit(unit);

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loggedInUser");
		List<Unit> units = unitDao.getUnits();
		model.put("units", units);
		model.put("user", user);
		model.put("assignedRole", true);
		List<User> userList = userDao.getUsers();
		model.put("userList", userList);
		List<Ticket> tickets = ticketDao.getTickets();
		model.put("tickets", tickets);
		return "ahomepage";
	}

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home() {
		System.out.println("inside home");
		return "homepage";
	}

	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signup() {
		System.out.println("inside signup");
		return "signup";
	}
}
