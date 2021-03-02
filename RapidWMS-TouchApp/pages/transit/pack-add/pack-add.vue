<template>
	<view>
		<form>
			<view class="title_area">基本信息</view>
			<view class="cu-form-group">
				<view class="title">客户</view>
				<picker @change="bindCustomerChange" :value="customerIndex" :range="allCustomers" range-key="name">
					<view class="picker" v-if="allCustomers.length > 0">{{ allCustomers[customerIndex].name }}</view>
				</picker>
			</view>
			<view class="cu-form-group">
				<view class="title">打包类型</view>
				<picker @change="bindPackTypeChange" :value="packTypeIndex" :range="packTypes">
					<view class="picker" v-if="packTypes.length > 0">{{ packTypes[packTypeIndex] }}</view>
				</picker>
			</view>
			<view class="cu-form-group">
				<view class="title">件数</view>
				<uni-number-box :min="1" :max="99999" :step="1" v-model="packages" @change="changePackages" />
			</view>
			<view class="cu-form-group" v-if="showLogistics">
				<view class="title">渠道</view>
				<picker @change="logisticsChange" range-key="name" :value="logisticsIndex" :range="logisticsTemplate">
					<view class="picker" v-if="logisticsTemplate.length > 0">{{ logisticsTemplate[logisticsIndex].name }}</view>
				</picker>
			</view>
			<view class="cu-form-group" v-if="showLogistics">
				<view class="title">重量</view>
				<input placeholder="重量kg" v-model="weight" />
			</view>
			<view class="cu-form-group" v-if="showLogistics">
				<view class="title">实际重量</view>
				<input placeholder="实际重量kg" v-model="realityWeight" />
			</view>
			<view class="cu-form-group">
				<view class="title">送货地址</view>
				<input disabled="true" :value="selectedAddressText" />
				<button class="cu-btn bg-green" @click="selectAddress" :disabled="packTypeIndex == 2">点击选择</button>
			</view>
			<view class="cu-form-group">
				<view class="title">物流单号</view>
				<input placeholder="选填" v-model="trackingNumber" />
			</view>
			<view class="cu-form-group">
				<view class="title">备注</view>
				<input placeholder="选填" v-model="description" />
			</view>
			<view class="button_area"><button class="cu-btn bg-blue add_item" @click="chooseFromOrders">选择订单</button></view>
			<view class="title_area">打包订单详情</view>
			<uni-list>
				<uni-swipe-action>
					<uni-swipe-action-item v-for="(order, index) in orders" :key="index" :right-options="options" @click="bindClickOrder(order.id)">
						<uni-list-item :show-arrow="false" :title="order.clientName+'-'+order.flowSn" :note="formatNote(order)" :show-badge="true" badge-type="error" :badge-text="order.totalPrice"/>
					</uni-swipe-action-item>
				</uni-swipe-action>
			</uni-list>
			<!-- <view class="price_total">
				订单总金额：<uni-tag class="price_tag" :circle="true" :text="formatPrice(totalPrice)" type="primary" size="small" />
			</view> -->
			<view class="padding flex flex-direction"><button class="cu-btn bg-blue margin-tb-sm lg" type="primary" :loading="loading" @click="savePack">保存打包</button></view>
		</form>
	</view>
</template>

<script>
import { uniList, uniListItem, uniTag, uniNumberBox } from '@dcloudio/uni-ui';

export default {
	components: { uniList, uniListItem, uniTag, uniNumberBox },
	data() {
		return {
			options: [
				{
					text: '删除',
					style: { backgroundColor: 'red' }
				}
			],
			customerIndex: 0,
			customerArray: [],
			packTypeIndex: 0,
			packTypes: ['市区派送', '外发物流', '自行提取'],
			packages: 1,
			orders: [],
			middleOrders: [],
			selectedAddressId: '',
			selectedAddressText: '',
			trackingNumber: '',
			description: '',
			// totalPrice: 0,
			loading: false,
			userId:undefined,
			logisticsIndex:0,
			logisticsTemplate:[],
			weight:null,
			realityWeight:null,
			showLogistics:false
		};
	},
	computed: {
		allCustomers() {
			return this.customerArray;
		},
		formatNote() {
			return order => {
				const { createTime, description, userGatherings, userReviewers, flowSn } = order;
				const userGath = userGatherings.map(item => item.num).join(',');
				const userRev = userReviewers.map(item => item.num).join(',');
				return (
					this.moment(createTime).format('YYYY-MM-DD HH:mm')  +
					' | ' +
					userGath +
					' | ' +
					userRev +
					' | ' +
					(description == '' ? '无说明' : description)
				);
			};
		}
	},
	methods: {
		bindCustomerChange(e) {
			if (this.customerIndex != e.target.value) {
				this.orders = [];
				// this.totalPrice = 0;
				this.customerIndex = e.target.value;
			}
		},
		bindClickOrder(value) {
			uni.showActionSheet({
				itemList: ['删除'],
				success: res => {
					// this.totalPrice -= this.orders.filter(order => order.id == value).shift().totalPrice;
					this.orders = this.orders.filter(order => order.id != value);
				}
			});
		},
		changePackages(value) {
			this.packages = value;
		},
		bindPackTypeChange(e) {
			this.showLogistics = false
			this.packTypeIndex = e.target.value;
			if (this.packTypeIndex == 2) {
				this.selectedAddressId = '';
				this.selectedAddressText = '';
			}else if(this.packTypeIndex === 1 ){
				this.showLogistics = true
			}
		},
		logisticsChange(e) {
			this.logisticsIndex = e.target.value;
		},
		initData() {
			this.api.get('/api/customers/all_list').then(res => {
				this.customerArray = res.data;
			});
			this.api.get('/api/Logistics_template/fetch_group_all').then(res => {
				this.logisticsTemplate = res.data;
			});
		},
		selectAddress() {
			uni.navigateTo({
				url: '../address-select/address-select',
				animationType: 'slide-in-right'
			});
		},
		chooseFromOrders() {
			if (this.customerArray.length > 0) {
				uni.navigateTo({
					url: '../order-select/order-page-select?customer=' + this.customerArray[this.customerIndex].id,
					animationType: 'slide-in-bottom'
				});
			}
		},
		savePack() {
			if(typeof(this.userId)==='undefined'){
				uni.showToast({
					title: '必须选择工作人员',
					icon: 'none'
				});
				return;
			}
			if (this.packTypeIndex != 2 && this.selectedAddressId == '') {
				uni.showToast({
					title: '必须选择地址',
					icon: 'none'
				});
				return;
			}
			if (this.orders.length===0) {
				uni.showToast({
					title: '必须选择订单',
					icon: 'none'
				});
				return;
			}
			let postData;
			if (this.packTypeIndex == 2) {
				postData = {
					customer: { id: this.customerArray[this.customerIndex].id },
					description: this.description,
					packType: this.packTypeIndex,
					packages: this.packages,
					trackingNumber: this.trackingNumber,
					customerOrderPages: this.orders
				};
			} else {
				postData = {
					address: { id: this.selectedAddressId },
					customer: { id: this.customerArray[this.customerIndex].id },
					description: this.description,
					packType: this.packTypeIndex,
					packages: this.packages,
					trackingNumber: this.trackingNumber,
					customerOrderPages: this.orders,
					weight:this.weight,
					realityWeight:this.realityWeight,
					logisticsTemplate:this.logisticsTemplate[this.logisticsIndex]
				};
			}
			Object.assign(postData,{user:{id:this.userId}})
			this.api
				.post('/api/packs', postData)
				.then(res => {
					if (res.statusCode == 201) {
						uni.showToast({
							title: '创建成功',
							icon: 'success',
							success: () => {
								setTimeout(() => {
									uni.$emit('addPackForPackList');
									uni.navigateBack();
								}, 1000);
							}
						});
					}
				})
				.finally(() => {
					this.loading = false;
				});
		}
	},
	onLoad(params) {
		this.userId = params.userId === 'undefined' ? undefined : params.userId;
		this.initData();
		uni.$on('addOrderForPackList', order => {
			if (this.middleOrders.every(item => item.id != order.id)) {
				this.middleOrders = [...this.orders].concat(order);
				// this.totalPrice += order.totalPrice;
			}
		});
		uni.$on('addAddressForPackList', address => {
			this.selectedAddressId = address.id;
			this.selectedAddressText = address.name;
		});
	},
	onUnload() {
		uni.$off('addOrderForPackList');
		uni.$off('addAddressForPackList');
	},
	onShow() {
		this.orders = [...this.middleOrders];
	}
};
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
	height: 120upx;
}
.add_item {
	margin: 25upx;
}
.right-checkbox {
	margin-left: 10upx;
}
.price_total {
	font-size: 25upx;
	line-height: 25upx;
	background: #ffffff;
	padding: 25upx;
	text-align: center;
	position: relative;
}
</style>
