<template>
	<view>
		<view class="flex padding justify-center">
			<image src="../../static/image/logo.png" mode="aspectFit" class="logo"></image>
		</view>
		<view class="flex padding justify-center">
			<view class="text-xl padding">
				<text class="text-black text-bold">设置服务器地址</text>
			</view>
		</view>
		<form>
			<view class="cu-form-group margin-top">
				<view class="title">地址</view>
				<input placeholder="http://server.address.org" v-model="serverAddress" type="text"></input>
			</view>
			<view class="padding flex flex-direction">
				<button class="cu-btn bg-blue margin-tb-sm lg" type="warn" @click="saveServerAddress">保 存</button>
			</view>
		</form>
	</view>
</template>

<script>

	export default {
		
		data() {
			return {
				serverAddress: "",
			}
		},
		methods: {
			saveServerAddress() {
				this.api.setBaseUrl(this.serverAddress, () => {
					uni.showToast({
						title: '保存成功',
						icon: 'success',
						success: () => {
							setTimeout(() => {
								uni.navigateBack();
							}, 1000);
							
						}
					});
				});
			},
		},
		onLoad() {
			const serverAddress = this.api.getBaseUrl();
			if (serverAddress) {
				this.serverAddress = serverAddress;
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
</style>
