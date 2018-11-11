package itgsd.model.dao;

import java.util.List;

import itgsd.model.Ticket;
import itgsd.model.Unit;
import itgsd.model.User;

public interface TicketDao {

    Ticket getTicket( Long id );

    List<Ticket> getTickets();

    List<Ticket> getTicketsCreatedBy( User user );

    List<Ticket> getTicketsCreatedFor( String email );

    List<Ticket> getTicketsAssignedTo( Unit unit );

    List<Ticket> getTicketsAssignedTo( User technician );
    
    Ticket saveTicket( Ticket ticket );
    
    void deleteTicket(Long id);

}
