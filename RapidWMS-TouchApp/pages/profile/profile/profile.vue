<template>
	<view>
		<view class='avatar_area'>
			<view class='user_area'>
				<view class="cu-avatar xl round" :style="avatar"></view>
				<view class="label">
					{{username}}
				</view>
				<view class="label">
					{{email}}
				</view>
			</view>
		</view>
		<view class='operate_area'>
			<uni-list>
				<uni-list-item :show-arrow="true" title="我的派送" @click="view_my_packages" />
			</uni-list>
		</view>
		<view class='operate_area'>
			<uni-list>
				<uni-list-item :show-arrow="true" title="更改头像" @click="change_avatar" />
				<uni-list-item :show-arrow="true" title="修改密码" @click="change_password" />
				<uni-list-item :show-arrow="true" title="关于" @click="about()" />
			</uni-list>
		</view>
		<view class='logout_area'>
			<button type="warn" @click="logout">退出登录</button>
		</view>
	</view>
</template>

<script>
	import {uniList, uniListItem} from '@dcloudio/uni-ui'

	export default {
		components: {uniList, uniListItem},
		data() {
			return {
				avatar: '',
				username: '',
				email: '',
			}
		},
		methods: {
			view_my_packages() {
				uni.navigateTo({
					animationType: "slide-in-right",
					url: "../my-packages/my-packages",
				})
			},
			logout() {
				uni.showModal({
					title: '退出',
					content: '确认退出登录？',
					success: (res) => {
						if (res.confirm) {
							uni.removeStorageSync('jwt-token');
							uni.reLaunch({
								url: '/pages/login/login'
							});
						}
					}
				});
			},
			change_password() {
				uni.navigateTo({
					animationType: "slide-in-right",
					url: "../change-password/change-password"
				});
			},
			change_avatar() {
				uni.chooseImage({
					count: 1,
					success: (chooseImageRes) => {
						const tempFilePaths = chooseImageRes.tempFilePaths;
						uni.uploadFile({
							url: this.api.getBaseUrl() + '/api/users/updateAvatar',
							filePath: tempFilePaths[0],
							name: 'avatar',
							header: {"Authorization": "Bearer " + uni.getStorageSync('jwt-token')},
							success: (uploadFileRes) => {
								uni.showToast({
									title: '上传成功',
									icon: 'success'
								});
								this.loadUserInfo();
							},
							fail: (err) => {
								console.log(err);
								uni.showToast({
									title: '上传失败',
									icon: 'none'
								});
							}
						});
					}
				});
			},
			loadUserInfo() {
				this.api.get("/auth/info").then(res => {
					this.avatar = "background-image:url(" + this.api.getBaseUrl() + res.data.avatar +")";
					this.username = res.data.username;
					this.email = res.data.email;
				});	
			},
			about() {
				uni.navigateTo({
					url: '../about/about'
				});
			}
		},
		onLoad() {
			this.loadUserInfo();
		},
	}
</script>

<style>
	.avatar_area {
		display: flex;
		justify-content: center;
		width: 100%;
		height: 350upx;
		background: #FFFFFF;
	}
	.user_area {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}
	.label {
		margin-top: 10upx;
	}
	.operate_area {
		margin-top: 30upx;
	}
	.logout_area {
		margin: 50upx;
	}
</style>
