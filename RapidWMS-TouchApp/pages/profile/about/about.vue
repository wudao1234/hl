<template>
	<view>
		<view class="flex padding justify-center">
			<image src="../../../static/image/logo.png" mode="aspectFit" class="logo"></image>
		</view>
		<view class="flex padding justify-center">
			<view class="text-xl padding">
				<text class="text-black text-bold">迅仓云 - 快速管理专家</text>
			</view>
		</view>
		<view class="text">
			Powered by Macrow
		</view>
		<view class="url" @tap="about()">
			<image src="../../../static/image/github-fill.png" mode="aspectFit" class="github"></image>https://github.com/Macrow
		</view>
	</view>
</template>

<script>
	export default {
		
		data() {
			return {
				
			}
		},
		methods: {
			about() {
				uni.showModal({
					title: '感谢',
					content: '我的邮箱是Macrow_wh@163.com，有问题可以联系我哦！😁',
					confirmText: '好的~',
					showCancel: false,
				});
			}
		}
	}
</script>

<style>	
	.logo {
		margin-top: 150upx;
		width: 200upx;
		height: 200upx;
	}
	.text {
		margin-top: 20upx;
		text-align: center;
	}
	.url {
		margin-top: 20upx;
		display: flex;
		justify-content: center;
		align-items: center;
		color: #0081FF;
	}
	.github {
		width: 50upx;
		height: 50upx;
		margin-right: 10upx;
	}
</style>
