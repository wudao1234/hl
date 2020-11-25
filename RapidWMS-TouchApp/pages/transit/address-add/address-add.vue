<template>
	<view>
		<form>
			<view class="title_area">地址基本信息</view>
			<view class="cu-form-group">
				<view class="title">地址名称</view>
				<input placeholder="必填" v-model="name"></input>
			</view>
			<view class="cu-form-group">
				<view class="title">地址类别</view>
				<picker @change="bindAddressTypeChange" :value="addressTypeIndex" :range="allAddressTypes" range-key="name">
					<view class="picker" v-if="allAddressTypes.length > 0">{{allAddressTypes[addressTypeIndex].name}}</view>
				</picker>
			</view>
			<view class="cu-form-group">
				<view class="title">联系人</view>
				<input placeholder="必填" v-model="contact"></input>
			</view>
			<view class="cu-form-group">
				<view class="title">联系电话</view>
				<input placeholder="必填" v-model="phone"></input>
			</view>
			<view class="cu-form-group">
				<view class="title">备注</view>
				<input placeholder="选填" v-model="description"></input>
			</view>
			<view class="padding flex flex-direction">
				<button class="cu-btn bg-blue margin-tb-sm lg" type="primary" :loading="loading" @click="saveAddress">保存地址</button>
			</view>
		</form>
	</view>
</template>

<script>
	import {uniList, uniListItem} from '@dcloudio/uni-ui'

	export default {
		components: {uniList, uniListItem},
		data() {
			return {
				addressTypeIndex: 0,
				addressTypeArray: [],
				isEdit: false,
				editId: '',
				name: '',
				contact: '',
				phone: '',
				description: '',
				loading: false,
			}
		},
		computed: {
			allAddressTypes() {
				return this.addressTypeArray;
			},	
		},
		methods: {
			bindAddressTypeChange(e) {
				if (this.addressTypeIndex != e.target.value) {
					this.addressTypeIndex = e.target.value;
				}
			},
			saveAddress() {
				if (this.name == '' || this.contact == '' || isNaN(this.phone)) {
					uni.showToast({
						title: '名称、联系人、联系电话为必填项，其中电话为数字',
						icon: 'none',
					});
					return;
				}
				this.loading = true;
				if (this.isEdit) {
					this.api.put("/api/address", {
						id: this.editId,
						name: this.name,
						contact: this.contact,
						phone: this.phone,
						description: this.description,
						addressType: {
							id: this.addressTypeArray[this.addressTypeIndex].id
						}
					}).then(res => {
						if (res.statusCode == 201) {
							uni.showToast({
								title: '修改成功',
								icon: 'success',
								success: () => {
									setTimeout(() => {
										uni.$emit('updateAddressList', {
											method: 'update',
											item: res.data,
										});
										uni.$emit('updateAddressDetail', res.data);
										uni.navigateBack();
									}, 1000);
								}
							});
						}
					}).finally(() => {
						this.loading = false;
					});
				} else {
					this.api.post("/api/address", {
						name: this.name,
						contact: this.contact,
						phone: this.phone,
						description: this.description,
						addressType: {
							id: this.addressTypeArray[this.addressTypeIndex].id
						}
					}).then(res => {
						if (res.statusCode == 201) {
							uni.showToast({
								title: '添加成功',
								icon: 'success',
								success: () => {
									setTimeout(() => {
										uni.$emit('updateAddressList', {
											method: 'add',
											item: res.data,
										});
										uni.navigateBack();
									}, 1000);
								}
							});
						}
					}).finally(() => {
						this.loading = false;
					});
				}
			}
		},
		onLoad(params) {
			this.api.get("/api/address_types/all_list").then(res => {
				this.addressTypeArray = res.data;
			});
			if (params.isEdit) {
				this.isEdit = true;
				this.editId = params.id;
			}
			if (this.isEdit) {
				uni.setNavigationBarTitle({
					title: '修改地址'
				});
				this.api.get("/api/address/" + this.editId).then(res => {
					if (res.statusCode == 200) {
						const address = res.data;
						this.name = address.name;
						this.contact = address.contact;
						this.phone = address.phone;
						this.description = address.description;
						const addressType = address.addressType.name;
						for (var i = 0; i < this.addressTypeArray.length; i++) {
							if (addressType == this.addressTypeArray[i].name) {
								this.addressTypeIndex = i;
								break;
							}
						}
					}
				});
			}
		},
	}
</script>

<style>
	.title_area {
		font-size: 25upx;
		line-height: 25upx;
		color: #777;
		margin: 25upx;
		position: relative;
	}
	.button_area {
		display: flex;
		justify-content: center;
		height: 100upx;
	}
	.add_item {
		margin: 25upx;
	}
	.empty {
		font-size: 25upx;
		display: flex;
		justify-content: center;
		align-items: center;
		height: 50upx;
		color: #777777;
	}
</style>
