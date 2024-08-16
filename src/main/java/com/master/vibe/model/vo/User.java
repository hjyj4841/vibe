package com.master.vibe.model.vo;

import java.util.Collection;
import java.util.Collections;
import java.util.Date;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor 
@Data @Builder
public class User implements UserDetails, Cloneable{
	private String userEmail;
	private String userPassword;
	private String userNickname;
	private String userImg;
	private Date userDate;
	private char userEntYn;
	private char userSpotifyYn;
	private String userGender;
	private Date userBirth;
	private char userManager;
	private Date userEnrollDate;
	private String userPhone;
	private String ageGroup;
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return Collections.emptyList();
	}
	@Override
	public String getPassword() {
		return userPassword;
	}
	@Override
	public String getUsername() {
		return userEmail;
	}
	
	@Override
    public boolean isEnabled() {
		return userEntYn == 'N' ? true : false;
    } 
	
	@Override
    public boolean isAccountNonExpired() {
        return true;
    }
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }
    
    @Override
    public User clone() throws CloneNotSupportedException{
    	return (User)super.clone();
    }
}
