package com.sofka.productcatalog.domain;


import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.Data;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.io.Serializable;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@Table(name = "category")
public class Category implements Serializable {
    /**
     * Variable usada para manejar el tema del identificador de la tupla (consecutivo)
     */
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cat_id", nullable = false)
    private Integer id;

    @Column(name = "cat_name", nullable = false, length = 80)
    private String catName;

    @Column(name = "cat_created_at", nullable = false)
    private Instant catCreatedAt;

    @OneToMany(
            fetch = FetchType.EAGER,
            targetEntity = Subcategory.class,
            cascade = CascadeType.REMOVE,
            mappedBy = "category"
    )
    @JsonManagedReference
    private List<Subcategory> subcategories = new ArrayList<>();

}