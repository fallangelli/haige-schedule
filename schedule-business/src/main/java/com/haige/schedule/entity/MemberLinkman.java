package com.haige.schedule.entity;


import com.fasterxml.jackson.annotation.JsonBackReference;
import com.haige.schedule.utils.Constants;

import javax.persistence.*;

@Entity
@Table(name = "member_linkman")
public class MemberLinkman {
    @Id
    @Column(nullable = false, unique = true)
    @GeneratedValue
    private Long id;


    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.REFRESH, CascadeType.MERGE})
    @JoinColumn(name = "memberId", nullable = false)
    @JsonBackReference
    private Member linkMember;

    @Column(nullable = false, length = 50)
    private String name;

    @Column(nullable = false, length = 50)
    private String relation;

    @Enumerated
    @Column(nullable = false)
    private Constants.Sex sex;

    @Column(length = 50)
    private String tel;

    @Column(length = 50)
    private String tel1;

    @Column(length = 50)
    private String tel2;

    @Column(length = 50)
    private String weChat;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Constants.Sex getSex() {
        return sex;
    }

    public void setSex(Constants.Sex sex) {
        this.sex = sex;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRelation() {
        return relation;
    }

    public void setRelation(String relation) {
        this.relation = relation;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getWeChat() {
        return weChat;
    }

    public void setWeChat(String weChat) {
        this.weChat = weChat;
    }

    public Member getLinkMember() {
        return linkMember;
    }

    public void setLinkMember(Member linkMember) {
        this.linkMember = linkMember;
    }

    public String getTel1() {
        return tel1;
    }

    public void setTel1(String tel1) {
        this.tel1 = tel1;
    }

    public String getTel2() {
        return tel2;
    }

    public void setTel2(String tel2) {
        this.tel2 = tel2;
    }
}
