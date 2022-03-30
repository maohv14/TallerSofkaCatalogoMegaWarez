package com.sofka.productcatalog.domain;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.Data;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import java.io.Serializable;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@Table(name = "item")
public class Item implements Serializable{
    /**
     * Variable usada para manejar el tema del identificador de la tupla (consecutivo)
     */
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "itm_id", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = Subcategory.class, optional = false)
    @JoinColumn(name = "itm_subcategory_id", nullable = false)
    @JsonBackReference
    private Subcategory subcategory;

    @Column(name = "itm_name", nullable = false, length = 80)
    private String itmName;

    @Column(name = "itm_created_at", nullable = false)
    private Instant itmCreatedAt;

    @OneToMany(
            fetch = FetchType.EAGER,
            targetEntity = Download.class,
            cascade = CascadeType.REMOVE,
            mappedBy = "item"
    )
    @JsonManagedReference
    private List<Download> downloads = new ArrayList<>();


}