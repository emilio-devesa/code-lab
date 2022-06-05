package core;

import org.hibernate.Session;
import persistence.HibernateUtil;

import javax.persistence.*;
import java.util.ArrayList;


/**
 * Class that modelates Issues to track (Bug, comment, feature)
 * @author Emilio Devesa
 * @version 0.1
 */
@Entity
@Table(name="ISSUES")
public class Issue {

    @Id
    @Column(name="ID", nullable = false)
    private long id;
    @Column(name="AUTHOR")
    private String author;
    @Column(name="DESCRIPTION")
    private String description;
    /*
        @Column(name="TAGS")
        private String[] tags;
        */
    @Column(name="PARENT")
    private long parent;

    public Issue() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public long getParent() {
        return parent;
    }

    public void setParent(long parent) {
        this.parent = parent;
    }


/*    public String[] getTags() {
        return tags;
    }

    public void setTags(String[] tags) {
        this.tags = tags;
    }

    public core.Issue[] getParentIssues() {
        return parentIssues;
    }

    public void setParentIssues(core.Issue[] parentIssues) {
        this.parentIssues = parentIssues;
    }*/


    /**
     * Saves the Issue object in the database
     */
    public void save(){
        Session session = HibernateUtil.getCurrentSession();
        session.beginTransaction();
        session.save(this);
        session.getTransaction().commit();
        session.close();
    }

    /**
     * Deletes this Issue object from the database
     */
    public void delete(){
        Session session = HibernateUtil.getCurrentSession();
        session.beginTransaction();
        session.delete(this);
        session.getTransaction().commit();
        session.close();
    }

    /**
     * Returns an object of class Issue, selected by ID from the DB
     * @param id long representing an object unique ID
     * @return Object from class Issue with the requested ID or null if it doesn't exist
     */
    public static Issue load(long id){
        return (Issue) HibernateUtil.getCurrentSession().get(Issue.class, id);
    }

    /**
     * Returns all objects from class Issue in the database
     * @return A new collection of type ArrayList containing all objects of class Issue in the database
     */
    public static ArrayList<Issue> get(){
        Query query = HibernateUtil.getCurrentSession().createQuery("FROM ISSUES");
        return (ArrayList<Issue>) ((org.hibernate.query.Query<?>) query).list();
    }

    public String toString(boolean printEverything){
        String result;
        if (printEverything){
            result= "ID: "+(Long.toString(this.getId()))+"\n"+
                    "ID padre: "+(Long.toString(this.getParent()))+"\n"+
                    "Autor: "+this.getAuthor()+"\n"+
                    "Descripcion: "+this.getDescription();

        } else {
            result=(Long.toString(this.getId()))+" "+this.getDescription();
        }
        return result;
    }

}
