package itgsd.model.dao;

import java.util.List;

import itgsd.model.Unit;
import itgsd.model.User;

public interface UserDao {

	User getUser(Long id);

	User getUser(String username);

	User getUserByEmail(String email);

	List<User> getUsers();

	User saveUser(User user);

	List<User> getTechniciansOfUnit(Unit unit);

}
