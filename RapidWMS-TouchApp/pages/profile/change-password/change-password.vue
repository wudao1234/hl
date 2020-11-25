<template>
	<view>
		<form>
			<view class="cu-form-group margin-top">
				<view class="title">原密码</view>
				<input placeholder="不少于6个字符" v-model="password" type="password"></input>
			</view>
			<view class="cu-form-group">
				<view class="title">新密码</view>
				<input placeholder="不少于6个字符" v-model="password2" type="password"></input>
			</view>
			<view class="padding flex flex-direction">
				<button class="cu-btn bg-blue margin-tb-sm lg" type="primary" :loading="loading" @click="change_password">更改密码</button>
			</view>
		</form>
	</view>
</template>

<script>
	import md5 from '../../../plugin/md5/build/md5.min.js'

	export default {
		data() {
			return {
				password: '',
				password2: '',
				loading: false,
			}
		},
		methods: {
			change_password() {
				if (this.password.length < 6) {
					uni.showToast({
						title: "原密码输入长度小于6个字符",
						icon: "none",
					});
					return;
				}
				if (this.password2.length < 6) {
					uni.showToast({
						title: "新密码输入长度小于6个字符",
						icon: "none",
					});
					return;
				}
				this.loading = true;
				this.api.put("/api/users/updatePassword", {
					oldPassword: md5(this.password),
					newPassword: md5(this.password2),
				}).then(res => {
					if (res.statusCode == 200) {
						uni.showToast({
							title: '修改成功',
							icon: 'success',
							success: () => {
								setTimeout(() => {
									uni.reLaunch({
										url: '/pages/login/login',
										success: () => {
											uni.showToast({
												title: '修改密码后需要重新登录',
												icon: 'none'
											});
										}
									});
								}, 2000);
							}
						});
					}
				}).finally(() => {
					this.loading = false;
				});
			}
		}
	}
</script>

<style>

</style>
