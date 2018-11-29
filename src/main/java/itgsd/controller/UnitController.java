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
public class UnitController {

	@Autowired
	private TicketDao ticketDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private UnitDao unitDao;

	@Autowired
	private UpdateDao updateDao;

	// edit a new unit.
	@RequestMapping(value = "/editUnit", method = RequestMethod.POST)
	public String editUnit(@ModelAttribute("editUnitForm") Unit unitForm, HttpServletRequest request,
			Map<String, Object> model) {

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loggedInUser");
		String unitId = request.getParameter("unitId");
		Unit unit = unitDao.getUnit(Long.parseLong(unitId));
		System.out.println("unitId: " + unitId);
		unit.setName(unitForm.getName());
		unit.setDescription(unitForm.getDescription());
		unit.setEmail(unitForm.getEmail());
		unit.setPhone(unitForm.getPhone());
		unit.setLocation(unitForm.getLocation());

		unitDao.saveUnit(unit);

		List<Unit> units = unitDao.getUnits();
		model.put("units", units);
		model.put("user", user);
		model.put("unitUpdated", true);
		List<User> userList = userDao.getUsers();
		model.put("userList", userList);
		List<Ticket> tickets = ticketDao.getTickets();
		model.put("tickets", tickets);
		return "ahomepage";
	}

	// edit a new unit.
	@RequestMapping(value = "/addUnit", method = RequestMethod.POST)
	public String addUnit(@ModelAttribute("addUnitForm") Unit unitForm, HttpServletRequest request,
			Map<String, Object> model) {

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loggedInUser");
		Unit unit = new Unit();
		unit.setName(unitForm.getName());
		unit.setDescription(unitForm.getDescription());
		unit.setEmail(unitForm.getEmail());
		unit.setPhone(unitForm.getPhone());
		unit.setLocation(unitForm.getLocation());

		unitDao.saveUnit(unit);

		List<Unit> units = unitDao.getUnits();
		model.put("units", units);
		model.put("user", user);
		model.put("unitUpdated", true);
		List<User> userList = userDao.getUsers();
		model.put("userList", userList);
		List<Ticket> tickets = ticketDao.getTickets();
		model.put("tickets", tickets);
		return "ahomepage";
	}

	@RequestMapping(value = "/deleteUnit", method = RequestMethod.GET)
	public String deleteTicket(HttpServletRequest request, Map<String, Object> model) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loggedInUser");
		Long unitId = Long.parseLong(request.getParameter("unitId"));
		unitDao.deleteUnit(unitId);
		List<Unit> units = unitDao.getUnits();
		model.put("units", units);
		model.put("user", user);
		model.put("unitUpdated", true);
		List<User> userList = userDao.getUsers();
		model.put("userList", userList);
		List<Ticket> tickets = ticketDao.getTickets();
		model.put("tickets", tickets);
		return "ahomepage";
	}

}
