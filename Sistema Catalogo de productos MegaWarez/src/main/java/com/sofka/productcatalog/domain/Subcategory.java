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
@Table(name = "subcategory")
public class Subcategory implements Serializable {
    /**
     * Variable usada para manejar el tema del identificador de la tupla (consecutivo)
     */
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "scat_id", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = Category.class, optional = false)
    @JoinColumn(name = "scat_category_id", nullable = false)
    @JsonBackReference
    private Category category;

    @Column(name = "scat_name", nullable = false, length = 80)
    private String scatName;

    @Column(name = "scat_created_at", nullable = false)
    private Instant scatCreatedAt;

    @OneToMany(
            fetch = FetchType.EAGER,
            targetEntity = Item.class,
            cascade = CascadeType.REMOVE,
            mappedBy = "subcategory"
    )
    @JsonManagedReference
    private List<Item> items = new ArrayList<>();

}