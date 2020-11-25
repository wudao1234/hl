<template>
	<view>
		<view class="cancel" v-if="orderStatus == 'CANCEL'">订单已作废，原因：{{cancelDescription}}</view>
		<view class="complete" v-if="orderStatus == 'COMPLETE'">订单已完成，回执金额：{{formatCompletePrice}} 说明：{{completeDescription}}</view>
		<view class="title">基本信息</view>
		<uni-list>
			<uni-list-item :show-arrow="false" :title="customerName" :show-badge="true" :badge-text="totalPrice" />
			<uni-list-item :show-arrow="false" :title="createTime" />
			<uni-list-item :show-arrow="false" :title="flowSn" />
			<uni-list-item :show-arrow="false" :title="autoIncreaseSn" />
			<uni-list-item :show-arrow="false" title="说明：" />
			<view class="content">{{description}}</view>
		</uni-list>
		<view class="title">订单客户</view>
		<uni-list>
			<uni-list-item :show-arrow="false" :title="clientName" />
			<uni-list-item :show-arrow="false" :title="clientAddress" />
			<uni-list-item :show-arrow="false" :title="clientStore" />
			<uni-list-item :show-arrow="false" :title="clientOrderSn" />
			<uni-list-item :show-arrow="false" :title="clientOperator" />
		</uni-list>
		<view class="title">商品出货明细</view>
		<uni-list>
			<uni-list-item v-for="item in orderItems" :key="item.id" :show-arrow="false" 
				:title="formatTitle(item.name, item.quantity)" 
				:note="formatNote(item.sn, item.price, item.quantityInitial, item.description)"
				:show-badge="true" :badge-text="formatPrice(item.price, item.quantity)" />
			<uni-list-item v-for="stock in orderStocks" :key="stock.id" :show-arrow="false" 
				:title="formatTitle(stock.goods.name, stock.quantity)" 
				:note="formatNote(stock.goods.sn, stock.price, stock.quantityInitial, stock.description)"
				:show-badge="true" :badge-text="formatPrice(stock.price, stock.quantity)" />	
		</uni-list>
		<view class="price_total">
			订单总金额：<uni-tag class="price_tag" :circle="true" :text="totalPriceInitial" type="primary" size="small" />
			出货总金额：<uni-tag class="price_tag" :circle="true" :text="totalPrice" type="success" size="small" />
		</view>
		<view class="title">操作记录</view>
		<view class="step_area">
			<uni-steps :options="operateSnapshots" :active="active" direction="column" />
		</view>
		<view class="padding flex flex-direction">
			<button class="cu-btn bg-red margin-tb-sm lg" type="danger" :loading="loading" v-if="orderStatus == 'INIT' || orderStatus == 'FETCH_STOCK'" @click="cancelOrder">作废订单</button>
			<button class="cu-btn bg-red margin-tb-sm lg" type="primary" :loading="loading" v-if="orderStatus == 'CLIENT_SIGNED'" @click="showConfirmOrder">确认回执</button>
			<button class="cu-btn bg-red margin-tb-sm lg" type="danger" :loading="loading" v-if="orderStatus == 'COMPLETE'" @click="showUpdateConfirmOrder">更新回执</button>
		</view>
		<view class="cu-modal" :class="showModal?'show':''">
			<view class="cu-dialog">
				<view class="cu-bar bg-white justify-end">
					<view class="content">填写作废原因</view>
					<view class="action" @tap="hideModal">
						<text class="cuIcon-close text-grey"></text>
					</view>
				</view>
				<view>
					<view class="cu-form-group">
						<input v-model="cancelDescription" class="input_area" placeholder="必须填入原因" maxlength="120" />
					</view>
				</view>
				<view class="cu-bar bg-white justify-end">
					<view class="action">
						<button class="cu-btn line-green text-green" @tap="hideModal">取消</button>
						<button class="cu-btn bg-blue margin-left" @tap="confirmCancel">确定</button>
					</view>
				</view>
			</view>
		</view>
		<view class="cu-modal" :class="showCompleteModal?'show':''">
			<view class="cu-dialog">
				<view class="cu-bar bg-white justify-end">
					<view class="content">填写回执确认信息</view>
					<view class="action" @tap="hideCompleteModal">
						<text class="cuIcon-close text-grey"></text>
					</view>
				</view>
				<view>
					<view class="cu-form-group">
						<view class="title">回执金额</view>
						<input v-model="completePrice" class="input_area" />
					</view>
					<view class="cu-form-group">
						<view class="title">签收情况</view>
						<view>
							<radio-group @change="receiveTypeChange">
								<label class="radio" v-for="item in receiveTypeItems" :key="item.value">
									<radio :value="item.value" :checked="radioCheck(item.value)" />{{item.name}}
								</label>
							</radio-group>
						</view>
					</view>
					<view class="cu-form-group">
						<view class="title">回执说明</view>
						<input v-model="completeDescription" placeholder="选填" class="input_area" />
					</view>
				</view>
				<view class="cu-bar bg-white justify-end">
					<view class="action">
						<button class="cu-btn line-green text-green" @tap="hideCompleteModal">取消</button>
						<button class="cu-btn bg-blue margin-left" @tap="confirmOrder">确定</button>
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	import {uniList, uniListItem, uniSteps, uniTag} from '@dcloudio/uni-ui'
	
	export default {
		components: {uniList, uniListItem, uniSteps, uniTag},
		data() {
			return {
				customerName: '',
				createTime: '',
				totalPrice: '',
				description: '',
				flowSn: '',
				autoIncreaseSn: '',
				clientName: '',
				clientAddress: '',
				clientStore: '',
				clientOrderSn: '',
				clientOperator: '',
				orderItems: [],
				orderStocks: [],
				operateSnapshots: [],
				orderStatus: '',
				loading: false,
				showModal: false,
				showCompleteModal: false,
				cancelDescription: '',
				orderId: '',
				completePrice: '',
				completeDescription: '',
				totalPriceRaw: '',
				receiveType: "0",
				receiveTypeItems: [
					{value: "0", name: '全签收'},
					{value: "1", name: '部分拒收'},
					{value: "2", name: '全拒收'},
				],
			}
		},
		computed: {
			radioCheck() {
				return (value) => {
					return value === this.receiveType;
				}
			},
			formatCompletePrice() {
				return this.accounting.formatMoney(this.completePrice);
			},
			formatTitle() {
				return (name, quantity) => {
					return `${this.accounting.formatNumber(quantity)} × ${name}`;
				}
			},
			formatNote() {
				return (sn, price, quantity, description) => {
					return `${sn} | ${this.accounting.formatMoney(price)} | 订单数:${this.accounting.formatNumber(quantity)}${description == '' ? '':'（已无库存）'}`;
				}
			},
			formatPrice() {
				return (price, quantity) => {
					return this.accounting.formatMoney(price * quantity);
				}
			},
			active() {
				return this.operateSnapshots.length - 1;
			},
			totalPriceInitial() {
				const orderItemsPrice = this.orderItems.map(item => {
					return item.price * item.quantityInitial;
				}).reduce((sum, totalPrice) => sum + totalPrice, 0);
				const orderStocksPrice = this.orderStocks.map(item => {
					return item.price * item.quantityInitial;
				}).reduce((sum, totalPrice) => sum + totalPrice, 0);
				return this.accounting.formatMoney(orderItemsPrice + orderStocksPrice);
			}
		},
		methods: {
			loadOrderDetail(id) {
				this.api.get(`/api/customer_orders/${id}`).then(res => {
					const order = res.data;
					this.customerName = "客户：" + order.owner.name;
					this.totalPriceRaw = order.totalPrice;
					this.totalPrice = this.accounting.formatMoney(order.totalPrice, '¥');
					this.createTime = "创建时间：" + this.moment(order.createTime).format("YYYY-MM-DD HH:mm");
					this.description = (order.description ? order.description : '');
					this.flowSn = "流水号：" + order.flowSn;
					this.autoIncreaseSn = "自定义编号：" + order.autoIncreaseSn;
					
					this.clientName = "名称：" + order.clientName;
					this.clientAddress = "地址：" + (order.clientAddress ? order.clientAddress : '');
					this.clientStore = "门店：" + order.clientStore;
					this.clientOrderSn = "订单号：" + (order.clientOrderSn ? order.clientOrderSn : '');
					this.clientOperator = "操作员：" + (order.clientOperator ? order.clientOperator : '');
					
					this.orderItems = order.customerOrderItems;
					this.orderStocks = order.customerOrderStocks;
					
					this.orderStatus = order.orderStatus;
					this.cancelDescription = order.cancelDescription ? order.cancelDescription : '';
					this.completePrice = order.completePrice ? order.completePrice : '';
					this.receiveType = order.receiveType ? this.convertReceiveType(order.receiveType) : '0';
					this.completeDescription = order.completeDescription ? order.completeDescription : '';
					
					this.operateSnapshots = order.operateSnapshots.map(item => {
						return {
							title: `${item.operation} - ${item.operator}`,
							desc: this.moment(item.createTime).format("YYYY-MM-DD HH:mm"),
						}
					});
				});
			},
			convertReceiveType(type) {
				switch (type){
					case 'ALL_SEND':
						return "0";
					case 'PARTIAL_REJECT':
						return "1";
					case 'ALL_REJECT':
						return '2';
					default:
						return "0";
				}
			},
			receiveTypeChange(evt) {
				this.receiveType = evt.target.value;
			},
			hideModal() {
				this.showModal = false;
			},
			hideCompleteModal() {
				this.showCompleteModal = false;
			},
			cancelOrder() {
				if (this.orderStatus == 'INIT' || this.orderStatus == 'FETCH_STOCK') {
					this.showModal = true;
				} else {
					uni.showModal({
						title: '不能作废订单',
						content: '只能作废“未分拣出货”的订单，如有问题，请联系客服',
						showCancel: false,
						confirmText: '确定',
					});
				}
			},
			confirmCancel() {
				if (this.cancelDescription.length > 0) {
					this.showModal = false;
					uni.hideKeyboard();
					this.loading = true;
					this.api.post("/api/customer_orders/cancel/" + this.orderId + "?description=" + this.cancelDescription).then(res => {
						if (res.statusCode == 201) {
							uni.$emit("cancelOrderList");
							uni.showToast({
								title: '作废成功',
								icon: 'success',
								success: () => {
									this.loadOrderDetail(this.orderId);
								}
							});
						}						
					}).finally(() => {
						this.loading = false;
					})
				}
			},
			showConfirmOrder() {
				this.completePrice = this.totalPriceRaw;
				this.completeDescription = '';
				this.showCompleteModal = true;
			},
			showUpdateConfirmOrder() {
				this.showCompleteModal = true;
			},
			confirmOrder() {
				const queryString = this.orderStatus == 'CLIENT_SIGNED' ? "/api/customer_orders/complete" : "/api/customer_orders/updateComplete";
				const price = Number.parseFloat(this.completePrice);
				if (isNaN(price)) {
					this.completePrice = 0;
					return;
				}
				this.completePrice = price.toFixed(2);
				if (this.completePrice > 0) {
					this.showCompleteModal = false;
					uni.hideKeyboard();
					this.loading = true;
					this.api.put(queryString, {						
						id: this.orderId,
						completePrice: this.completePrice,
						receiveType: this.receiveType,
						completeDescription: this.completeDescription,
					}).then(res => {
						if (res.statusCode == 201) {
							uni.$emit("completeOrderList", this.orderId);
							uni.showToast({
								title: '操作成功',
								icon: 'success',
								success: () => {
									if (this.orderStatus == 'CLIENT_SIGNED') {
										uni.$emit('updateOrderList', this.orderId);
									}
									this.loadOrderDetail(this.orderId);
								}
							});
						}						
					}).finally(() => {
						this.loading = false;
					})
				}
			},
		},
		onLoad(params) {
			this.orderId = params.id;
			this.loadOrderDetail(this.orderId);
		}
	}
</script>

<style>
	.cancel {
		font-size: 25upx;
		line-height: 25upx;
		color: white;
		background: #E54D42;
		padding: 35upx;
		position: relative;
		text-align: center;
	}
	.complete {
		font-size: 25upx;
		line-height: 25upx;
		color: white;
		background: green;
		padding: 35upx;
		position: relative;
		text-align: center;
	}
	.title {
		font-size: 25upx;
		line-height: 25upx;
		color: #777;
		margin: 25upx;
		position: relative;
	}
	.content {
		font-size: 35upx;
		line-height: 35upx;
		margin: 30upx;
		position: relative;
	}
	.price_total {
		font-size: 25upx;
		line-height: 25upx;
		background: #FFFFFF;
		padding: 25upx;
		text-align: center;
		position: relative;
	}
	.step_area {
		background: #FFFFFF;
	}
	.price_tag {
		margin-right: 25upx;
	}
	.input_area {
		background: #EEEEEE;
	}
</style>
