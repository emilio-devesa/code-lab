package com.emiliodevesa.kot.core;

import javax.persistence.*;


/**
 * Class that modelates Issues to track (Bug, comment, feature)
 * @author Emilio Devesa
 * @version 0.1
 */
@Entity
@Table(name="ISSUES")
public class Issue {

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private long id;
    @Column(nullable = false, length=50)
    private String author;
    @Column(nullable = false, length=200)
    private String description;
    @Column
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
