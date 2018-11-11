package itgsd.model.dao.jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import itgsd.model.Unit;
import itgsd.model.User;
import itgsd.model.dao.UnitDao;

@Repository
public class UnitDaoImpl implements UnitDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public Unit getUnit( Long id )
    {
        return entityManager.find( Unit.class, id );
    }
    
    @Override
	public Unit getUnitByName(String name) {
    	String query = "from Unit where name = :name";

		List<Unit> units = entityManager.createQuery(query, Unit.class).setParameter("name", name.toLowerCase())
				.getResultList();
		return units.size() == 0 ? null : units.get(0);
	}

    @Override
    public List<Unit> getUnits()
    {
        return entityManager.createQuery( "from Unit order by id", Unit.class )
            .getResultList();
    }

    @Override
    @Transactional
    public Unit saveUnit( Unit unit )
    {
        return entityManager.merge( unit );
    }

	

}
