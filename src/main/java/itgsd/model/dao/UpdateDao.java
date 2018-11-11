package itgsd.model.dao;

import java.util.List;

import itgsd.model.Update;

public interface UpdateDao {

    Update getUpdate( Long id );

    List<Update> getUpdates();

    Update saveUpdate( Update update );

}