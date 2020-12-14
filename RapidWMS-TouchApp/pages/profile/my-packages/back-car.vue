<template>
	<view>
		<form>
			<view class="cu-form-group margin-top">
				<view class="title">里程</view>
				<input placeholder="请输入里程" v-model="backCar.mileage" type="number" />
			</view>
			<view class="cu-form-group">
				<view class="title">系统系数</view>
				<picker @change="coefficientChange" :value="index" :range="array" range-key="name">
					<view class="uni-input">{{ array[index].name }}</view>
				</picker>
			</view>
			<view class="padding flex flex-direction"><button class="cu-btn bg-blue margin-tb-sm lg" type="primary" @click="submit">确定</button></view>
		</form>
	</view>
</template>

<script>
export default {
	data() {
		return {
			array: [{name:'请选择',value:0}],
			index: 0,
			backCar: { dispatchSys: 0, mileage: 5 }
		};
	},
	created() {
		this.loadCoefficient();
	},
	methods: {
		loadCoefficient() {
			this.api.get('/api/dispatch_sys').then(res => {
				if (res.statusCode == 200) {
					this.array = res.data.content;
				}
			});
		},
		coefficientChange(val) {
			this.index = val.detail.value;
			this.backCar.dispatchSys = this.array[this.index].id;
			console.log(this.backCar);
		},
		submit() {
			if (this.backCar.mileage <= 0) {
				uni.showToast({
					title: '里程不能小于0',
					icon: 'none'
				});
				return;
			}
			this.api.get(`/api/dispatch/finish?dispatchSys=${this.backCar.dispatchSys}&mileage=${this.backCar.mileage}`)
			.then(res => {
				if (res.statusCode == 201) {
					uni.showToast({
						title: '收车成功',
						icon: 'success'
					});
				}
			});
		}
	}
};
</script>

<style></style>
