<template>
	<view>
		<view class="title">总件数</view>
		<uni-list><uni-list-item :show-arrow="false" :title="'总件数：' + packages" /></uni-list>
		<view class="title">件码分配</view>
		<uni-list>
			<block v-for="item in packItems" :key="item.id">
				<uni-swipe-action>
					<uni-swipe-action-item :right-options="options" @click="bindClickPackItem(item)">
						<uni-list-item
							:key="item.id"
							:show-arrow="false"
							:title="formatTitle(item.name, item.number)"
							:note="formatGoodsNote(item.sn, item.expireDate)"
							:show-badge="true"
							:badge-text="item.quantity + ''"
							badge-type="error"
						/>
					</uni-swipe-action-item>
				</uni-swipe-action>
			</block>
		</uni-list>
		<view class="price_total" v-if="packItems.length == 0">暂未分配分件信息</view>
		<view class="title">待分配商品</view>
		<uni-list>
			<uni-list-item
				clickable
				v-for="stock in stockFlows"
				:key="stock.id"
				:show-arrow="true"
				:title="formatTitle2(stock.name, stock.quantity)"
				:note="formatGoodsNote(stock.sn, stock.expireDate)"
				@click="addItem(stock)"
				:show-badge="true"
				:badge-text="stock.quantity + ''"
				badge-type="error"
			/>
		</uni-list>
		<view class="price_total" v-if="stockFlows.length == 0">已分配完毕</view>
		<view class="padding flex flex-direction">
			<button class="cu-btn bg-blue margin-tb-sm lg" :loading="loading" @click="scanGoods">扫描商品</button>
			<button class="cu-btn bg-red margin-tb-sm lg" :loading="loading" @click="packagePack">确认分包</button>
		</view>
		<view class="cu-modal" :class="showModal ? 'show' : ''">
			<view class="cu-dialog">
				<view class="cu-bar bg-white justify-end">
					<view class="content">填写分件信息</view>
					<view class="action" @tap="hideModal"><text class="cuIcon-close text-grey"></text></view>
				</view>
				<view>
					<view class="cu-form-group">
						<text class="text-center">{{ inputGoodsName }}</text>
					</view>
					<view class="cu-form-group">
						<view class="title">条码</view>
						<text>{{ inputGoodsSn }}</text>
					</view>
					<view class="cu-form-group">
						<view class="title">件号</view>
						<uni-number-box :value="inputNumber" @change="changeNumber" :min="1" :max="packages" class="input_area" />
					</view>
					<view class="cu-form-group">
						<view class="title">数量</view>
						<uni-number-box :value="inputQuantity" @change="changeQuantity" :min="1" :max="selectedStockFlow.quantity" class="input_area" />
					</view>
				</view>
				<view class="cu-bar bg-white justify-end">
					<view class="action">
						<button class="cu-btn line-green text-green" @tap="hideModal">取消</button>
						<button class="cu-btn bg-blue margin-left" @tap="confirmPackage">确定</button>
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
import intformat from '../../../plugin/biguint-format/index.js';
import FlakeId from '../../../plugin/flake-idgen/flake-id-gen.js';
const flakeIdGen1 = new FlakeId();
import { uniList, uniListItem, uniNumberBox, uniSwipeAction } from '@dcloudio/uni-ui';

export default {
	components: { uniList, uniListItem, uniNumberBox, uniSwipeAction },
	data() {
		return {
			options: [
				{
					text: '删除',
					style: { backgroundColor: 'red' }
				}
			],
			packId: '',
			packages: 0,
			packItems: [],
			middlePackItems: [],
			stockFlows: [],
			loading: false,
			showModal: false,
			inputGoodsName: '',
			inputGoodsSn: '',
			inputNumber: 1,
			inputQuantity: 0,
			selectedStockFlow: { quantity: 0 }
		};
	},
	computed: {
		formatTitle() {
			return (name, number) => {
				return '#' + number + ' ' + name;
			};
		},
		formatTitle2() {
			return name => {
				return name;
			};
		},
		formatNote() {
			return (flowSn, address) => {
				return `${flowSn} | ${address}`;
			};
		},
		formatGoodsNote() {
			return (sn, expireDate) => {
				return `${sn} | ${this.moment(expireDate).format('YYYY-MM-DD')}`;
			};
		}
	},
	methods: {
		loadPackDetail(id) {
			this.api.get(`/api/packs/${id}`).then(res => {
				const pack = res.data;
				this.packages = pack.packages;
				this.packItems = pack.packItems.sort((a, b) => a.number - b.number);
				if (this.packItems !== undefined && this.packItems.length > 0) {
					this.stockFlows = [];
				} else {
					this.api.get(`/api/packs/${id}/stock_flows`).then(res => {
						this.stockFlows = res.data;
					});
				}
			});
		},
		changeNumber(value) {
			this.inputNumber = parseInt(value);
		},
		changeQuantity(value) {
			this.inputQuantity = parseInt(value);
		},
		hideModal() {
			this.showModal = false;
		},
		packagePack() {
			this.loading = true;
			this.api
				.post('/api/packs/packages', {
					id: this.packId,
					packItems: this.packItems
				})
				.then(res => {
					if (res.statusCode == 201) {
						uni.showToast({
							title: '分包成功',
							icon: 'success',
							success: () => {
								setTimeout(() => {
									uni.$emit('updatePackDetail');
									uni.navigateBack();
								}, 1000);
							}
						});
					}
				})
				.finally(() => {
					this.loading = false;
				});
		},
		scanGoods() {
			uni.scanCode({
				success: res => {
					console.log(res.result);
					if (this.includeGoodsSn(res.result)) {
						for (var i = 0; i < this.stockFlows.length; i++) {
							if (this.stockFlows[i].sn == res.result) {
								this.addItem(this.stockFlows[i]);
							}
						}
					} else {
						uni.showToast({
							title: '条码不符',
							icon: 'none'
						});
					}
				}
			});
		},
		includeGoodsSn(sn) {
			for (var i = 0; i < this.stockFlows.length; i++) {
				if (this.stockFlows[i].sn == sn) {
					return true;
				}
			}
			return false;
		},
		bindClickPackItem(itemRemove) {
			const packItems = this.packItems;
			const stockFlows = this.stockFlows;
			const newPackItems = packItems.filter(item => item.id !== itemRemove.id || item.number !== itemRemove.number);
			let findItem = false;
			for (let i = 0; i < stockFlows.length; i += 1) {
				if (stockFlows[i].sn === itemRemove.sn && stockFlows[i].expireDate === itemRemove.expireDate) {
					stockFlows[i] = { ...stockFlows[i], quantity: stockFlows[i].quantity + itemRemove.quantity };
					findItem = true;
					break;
				}
			}
			if (!findItem) {
				this.stockFlows.push(itemRemove);
			} else {
				this.stockFlows = stockFlows;
			}
			this.packItems = newPackItems;
		},
		addItem(item) {
			this.selectedStockFlow = item;
			this.inputGoodsName = item.name;
			this.inputGoodsSn = item.sn;
			this.inputQuantity = item.quantity;
			this.showModal = true;
		},
		confirmPackage() {
			const newItem = {
				id: intformat(flakeIdGen1.next(), 'dec'),
				pack: { id: this.packId },
				number: this.inputNumber,
				quantity: this.inputQuantity,
				name: this.selectedStockFlow.name,
				sn: this.selectedStockFlow.sn,
				expireDate: this.selectedStockFlow.expireDate
			};
			let findPackItem = false;
			for (let i = 0; i < this.packItems.length; i++) {
				if (this.packItems[i].sn === newItem.sn && this.packItems[i].expireDate === newItem.expireDate && this.packItems[i].number === newItem.number) {
					this.packItems[i] = { ...this.packItems[i], quantity: this.packItems[i].quantity + newItem.quantity };
					findPackItem = true;
					break;
				}
			}
			for (let i = 0; i < this.stockFlows.length; i++) {
				if (this.stockFlows[i].id === this.selectedStockFlow.id) {
					if (this.inputQuantity >= this.stockFlows[i].quantity) {
						this.stockFlows.splice(i, 1);
						break;
					}
					if (this.inputQuantity < this.stockFlows[i].quantity) {
						const updateItem = this.stockFlows[i];
						updateItem.quantity = this.stockFlows[i].quantity - this.inputQuantity;
						this.stockFlows[i] = updateItem;
						break;
					}
				}
			}
			if (!findPackItem) {
				const items = this.packItems;
				items.push(newItem);
				items.sort((a, b) => a.number - b.number);
				this.packItems = items;
			}
			this.showModal = false;
		}
	},
	onLoad(params) {
		this.packId = params.id;
		this.loadPackDetail(this.packId);
	}
};
</script>

<style>
.title {
	font-size: 25upx;
	line-height: 25upx;
	color: #777;
	margin: 25upx;
	position: relative;
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
