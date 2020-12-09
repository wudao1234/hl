<template>
	<view>
		<view class="flex padding justify-center">
			<image src="../../static/image/logo.png" mode="aspectFit" class="logo"></image>
		</view>
		<view class="flex padding justify-center">
			<view class="text-xl padding">
				<text class="text-black text-bold">展鹿商贸仓储</text>
			</view>
		</view>
		<form>
			<view class="cu-form-group margin-top">
				<view class="title">登录名</view>
				<input placeholder="不少于2个字符" v-model="username" type="text"></input>
			</view>
			<view class="cu-form-group">
				<view class="title">密码</view>
				<input placeholder="不少于6个字符" v-model="password" type="password"></input>
			</view>
			<view class="padding" @click="check_remember">
				<checkbox :class="rememberMe ? 'checked remember' : 'remember'" class :checked="rememberMe" />记住密码
			</view>
			<view class="padding flex flex-direction">
				<button class="cu-btn bg-blue margin-tb-sm lg" type="primary" :loading="loading" @click="login">登 录</button>
			</view>
			<view class="padding flex flex-direction server-setting">
				<span @click="setServer">配置服务器地址</span>
			</view>
		</form>
	</view>
</template>

<script>
	import md5 from '../../plugin/md5/build/md5.min.js'

	export default {
		
		data() {
			return {
				username: "",
				password: "",
				loading: false,
				rememberMe: false, 
			}
		},
		methods: {
			check_remember() {
				this.rememberMe = !this.rememberMe;
			},
			login() {
				if (this.username.length < 2) {
					uni.showToast({
						title: "用户名不少于2个字符",
						icon: "none",
					});
					return;
				}
				if (this.password.length < 6) {
					uni.showToast({
						title: "密码不少于6个字符",
						icon: "none",
					});
					return;
				}
				this.loading = true;
				uni.setStorage({
					key: 'username',
					data : this.username,
				});
				uni.setStorage({
					key: 'rememberMe',
					data: this.rememberMe,
				});
				if (this.rememberMe == true) {
					uni.setStorage({
						key: 'password',
						data: this.password,
					});
				} else {
					uni.setStorage({
						key: 'password',
						data: '',
					});
				}
				this.api.post("/auth/login", {
					username: this.username,
					password: md5(this.password),
				}).then(res => {
					if (res.statusCode == 200) {
						uni.setStorage({
							key: 'jwt-token',
							data: res.data.token,
							success: () => {
								uni.reLaunch({
									url: '/pages/dashboard/dashboard',
								});
							},
							fail: () => {
								uni.showToast({
									title: '无法存储登录信息，请检查相关权限',
									icon: 'none'
								});
							}
						});
					}
				}).finally(() => {
					this.loading = false;
				});
			},
			setServer() {
				uni.navigateTo({
					url: '../server-setting/server-setting',
					animationType: 'slide-in-bottom',
				});
			}
		},
		onLoad() {
			const username = uni.getStorageSync('username');
			if (username) {
				this.username = username;
			}
			const password = uni.getStorageSync('password');
			if (password) {
				this.password = password;
			}
			const rememberMe = uni.getStorageSync('rememberMe');
			if (rememberMe) {
				this.rememberMe = rememberMe;
			}
		}
	}
</script>

<style>	
	.cu-form-group .title {
		min-width: calc(4em + 15px);
	}
	.logo {
		width: 200upx;
		height: 200upx;
	}
	.server-setting {
		align-items: center;
		color: grey;
		font-size: 25upx;
	}
	.remember {
		margin-right: 10upx;
	}
</style>
