package itgsd.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import itgsd.model.NewTicketForm;
import itgsd.model.Ticket;
import itgsd.model.Unit;
import itgsd.model.Update;
import itgsd.model.User;
import itgsd.model.dao.TicketDao;
import itgsd.model.dao.UnitDao;
import itgsd.model.dao.UpdateDao;
import itgsd.model.dao.UserDao;

@Controller
public class TicketController {

	@Autowired
	private TicketDao ticketDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private UnitDao unitDao;

	@Autowired
	private UpdateDao updateDao;

	// Create a new ticket.
	@RequestMapping(value = "/createTicket", method = RequestMethod.POST)
	public String addTicket(@ModelAttribute("createTicketForm") NewTicketForm ticketForm, HttpServletRequest request,
			Map<String, Object> model) {

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loggedInUser");
		Unit unit = unitDao.getUnitByName(ticketForm.getUnit());
		Ticket t = new Ticket();
		t.setCreatedBy(user);
		t.setCreatedForEmail(user.getEmail());
		t.setSubject(ticketForm.getSubject());
		t.setDetails(ticketForm.getDescription());
		t.setUnit(unit);
		t.setPriority(Ticket.Priority.LOW);
		t.setStatus(Ticket.Status.OPEN);
		t.setDateCreated(new Date());
		ticketDao.saveTicket(t);
		List<Ticket> tickets = ticketDao.getTicketsCreatedBy(user);
		List<Unit> units = unitDao.getUnits();
		model.put("user", user);
		model.put("tickets", tickets);
		model.put("units", units);
		model.put("ticketCreated", true);
		if (user.getType().equals(User.Type.REGULAR))
			return "homepage";
		if (user.getType().equals(User.Type.SUPERVISOR))
			return "shomepage";
		if (user.getType().equals(User.Type.TECHNICIAN))
			return "thomepage";
		return "ahomepage";
	}

	@RequestMapping(value = "/assignTicket", method = RequestMethod.POST)
	public String assignTicketToTechnician(HttpServletRequest request, Map<String, Object> model) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loggedInUser");
		String technicianEmail = request.getParameter("technician");
		Long ticketId = Long.parseLong(request.getParameter("ticketId"));

		System.out.println(">>" + technicianEmail + "<>" + ticketId);
		User techinician = userDao.getUserByEmail(technicianEmail);
		Ticket ticket = ticketDao.getTicket(ticketId);
		List<User> techincians = new ArrayList<>();
		techincians.add(techinician);
		ticket.setTechnicians(techincians);
		ticket.setDateAssigned(new Date());
		ticket.setStatus(Ticket.Status.ASSIGNED);
		ticketDao.saveTicket(ticket);
		model.put("ticketAssigned", true);
		List<Ticket> tickets = ticketDao.getTicketsAssignedTo(user.getUnit());
		List<Unit> units = unitDao.getUnits();
		model.put("units", units);
		model.put("tickets", tickets);
		model.put("user", user);
		if (user.getType().equals(User.Type.ADMIN)) {
			List<User> userList = userDao.getUsers();
			model.put("userList", userList);
			List<Ticket> alltickets = ticketDao.getTickets();
			model.put("tickets", alltickets);
			return "ahomepage";
		}
		return "shomepage";
	}

	@RequestMapping(value = "/deleteTicket", method = RequestMethod.GET)
	public String deleteTicket(HttpServletRequest request, Map<String, Object> model) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loggedInUser");
		Long ticketId = Long.parseLong(request.getParameter("ticketId"));
		ticketDao.deleteTicket(ticketId);
		model.put("ticketDeleted", true);
		List<Ticket> tickets = ticketDao.getTicketsAssignedTo(user.getUnit());
		List<Unit> units = unitDao.getUnits();
		model.put("units", units);
		model.put("tickets", tickets);
		model.put("user", user);
		if (user.getType().equals(User.Type.ADMIN)) {
			List<User> userList = userDao.getUsers();
			model.put("userList", userList);
			List<Ticket> alltickets = ticketDao.getTickets();
			model.put("tickets", alltickets);
			return "ahomepage";
		}
		return "shomepage";
	}

	@RequestMapping(value = "/editTicket", method = RequestMethod.POST)
	public String editTicket(HttpServletRequest request, Map<String, Object> model) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loggedInUser");
		Long ticketId = Long.parseLong(request.getParameter("ticketId"));
		String status = request.getParameter("status");
		String priority = request.getParameter("priority");
		Ticket ticket = ticketDao.getTicket(ticketId);
		if (priority.equals("LOW"))
			ticket.setPriority(Ticket.Priority.LOW);
		else if (priority.equals("MEDIUM"))
			ticket.setPriority(Ticket.Priority.MEDIUM);
		else if (priority.equals("HIGH"))
			ticket.setPriority(Ticket.Priority.HIGH);

		if (status.equals("OPEN")) {
			ticket.setStatus(Ticket.Status.OPEN);
			ticket.setDateUpdated(new Date());
		} else if (status.equals("ASSIGNED")) {
			ticket.setStatus(Ticket.Status.ASSIGNED);
			ticket.setDateUpdated(new Date());
		} else if (status.equals("ONHOLD")) {
			ticket.setStatus(Ticket.Status.ONHOLD);
			ticket.setDateUpdated(new Date());
		} else if (status.equals("COMPLETED")) {
			ticket.setStatus(Ticket.Status.COMPLETED);
			ticket.setDateUpdated(new Date());
		} else if (status.equals("CLOSED")) {
			ticket.setStatus(Ticket.Status.CLOSED);
			ticket.setDateUpdated(new Date());
			ticket.setDateClosed(new Date());
		}

		ticketDao.saveTicket(ticket);
		model.put("ticketUpdated", true);
		model.put("user", user);
		List<Unit> units = unitDao.getUnits();
		model.put("units", units);

		if (user.getType().equals(User.Type.ADMIN)) {
			List<User> userList = userDao.getUsers();
			model.put("userList", userList);
			List<Ticket> alltickets = ticketDao.getTickets();
			model.put("tickets", alltickets);
			return "ahomepage";
		}
		if (user.getType().equals(User.Type.TECHNICIAN)) {
			List<Ticket> tickets = ticketDao.getTicketsAssignedTo(user);
			model.put("tickets", tickets);
			return "thomepage";
		}

		List<Ticket> tickets = ticketDao.getTicketsAssignedTo(user.getUnit());
		model.put("tickets", tickets);
		return "shomepage";
	}
}
