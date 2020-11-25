package org.mstudio.modules.system.service.dto;

import lombok.Data;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @date 2018-12-03
 */
@Data
public class PermissionDTO implements Serializable{

	private Long id;

	private String name;

	private Integer sort;

	private Long pid;

	private String alias;

	private Timestamp createTime;

	private List<PermissionDTO>  children;

	@Override
	public String toString() {
		return "Permission{" +
				"id=" + id +
				", name='" + name + '\'' +
				", sort='" + sort + '\'' +
				", pid=" + pid +
				", alias='" + alias + '\'' +
				", createTime=" + createTime +
				'}';
	}
}
