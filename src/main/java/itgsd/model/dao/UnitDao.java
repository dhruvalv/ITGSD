package itgsd.model.dao;

import java.util.List;

import itgsd.model.Unit;

public interface UnitDao {

	Unit getUnit(Long id);

	Unit getUnitByName(String name);

	List<Unit> getUnits();

	Unit saveUnit(Unit unit);
	
	void deleteUnit(Long id);

}
