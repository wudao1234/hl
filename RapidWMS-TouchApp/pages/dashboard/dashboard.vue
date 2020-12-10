<template>
	<view v-if="false">
		<uni-card class='card' title="今日销售额" :note="'今日订单数： ' + orderCountToday">
			{{totalPriceToday}}
		</uni-card>
		<uni-card class='card' title="待分拣订单数" :note="'今日已分拣订单数： ' + confirmOrdersToday">
			{{unConfirmOrders}}
		</uni-card>
		<uni-card class='card' title="今日打包票数" :note="'今日打包票据单数： ' + packCountToday">
			{{packCountDetailToday}}
		</uni-card>
		<uni-card class='card' title="待派送打包票数" :note="'待派送打包票据单数： ' + packCountSending">
			{{packCountDetailSending}}
		</uni-card>
		<uni-segmented-control class='segment' :current="current" :values="items" @clickItem="onClickItem" style-type="button"
		 active-color="#1296db"></uni-segmented-control>
		<view class='chart'>
			<!--#ifdef MP-ALIPAY -->
			<canvas canvas-id="canvasColumn" id="canvasColumn" class="charts" :style="{'width':cWidth*pixelRatio+'px','height':cHeight*pixelRatio+'px', 'transform': 'scale('+(1/pixelRatio)+')','margin-left':-cWidth*(pixelRatio-1)/2+'px','margin-top':-cHeight*(pixelRatio-1)/2+'px'}"
			 @touchstart="touchColumn"></canvas>
			<!--#endif-->
			<!--#ifndef MP-ALIPAY -->
			<canvas canvas-id="canvasColumn" id="canvasColumn" class="charts" @touchstart="touchColumn"></canvas>
			<!--#endif-->
		</view>
		<view class="list-title">单品销售排行榜</view>
		<uni-list>
			<uni-list-item v-for="(item, index) in topSales" :key="index" :show-arrow="false" :title="index + 1 + '.' + item.name"
			 :show-badge="true" :badge-text="item.totalPrice" />
		</uni-list>
	</view>
</template>

<script>
	import {
		uniCard,
		uniSegmentedControl,
		uniList,
		uniListItem
	} from '@dcloudio/uni-ui'
	import uCharts from '../../plugin/u-charts/u-charts.min.js';
	let _self;
	let canvaColumn = null;
	export default {
		components: {
			uniCard,
			uniSegmentedControl,
			uniList,
			uniListItem
		},
		data() {
			return {
				completeLoadingToday: false,
				completeLoadingChart: false,
				totalPriceToday: 0,
				orderCountToday: 0,
				unConfirmOrders: 0,
				confirmOrdersToday: 0,
				packCountDetailToday: 0,
				packCountToday: 0,
				packCountDetailSending: 0,
				packCountSending: 0,
				items: ['今日', '本周', '本月', '本年'],
				current: 0,
				cWidth: '',
				cHeight: '',
				pixelRatio: 1,
				topSales: [],
			}
		},
		computed: {

		},
		onLoad() {
			uni.showToast({
				title: '欢迎回来',
				icon: 'none',
			});
			_self = this;
			//#ifdef MP-ALIPAY
			uni.getSystemInfo({
				success: function(res) {
					if (res.pixelRatio > 1) {
						//正常这里给2就行，如果pixelRatio=3性能会降低一点
						//_self.pixelRatio =res.pixelRatio;
						_self.pixelRatio = 2;
					}
				}
			});
			//#endif
			this.cWidth = uni.upx2px(750);
			this.cHeight = uni.upx2px(500);
			uni.startPullDownRefresh();
		},
		onPullDownRefresh() {
			this.getTodayData();
			this.getChartData(this.getCurrentChartType());
		},
		methods: {
			stopLoading() {
				if (this.completeLoadingToday && this.completeLoadingChart) {
					uni.stopPullDownRefresh();
				}
			},
			getTodayData() {
				this.completeLoadingToday = false;
				this.api.get("/api/kpi/dashboard_today").then(res => {
					const todayData = res.data;
					this.totalPriceToday = this.accounting.formatMoney(todayData.totalPriceToday);
					this.orderCountToday = this.accounting.formatNumber(todayData.orderCountToday);
					this.unConfirmOrders = this.accounting.formatNumber(todayData.unConfirmOrders);
					this.confirmOrdersToday = this.accounting.formatNumber(todayData.confirmOrdersToday);
					this.packCountDetailToday = this.accounting.formatNumber(todayData.packCountDetailToday);
					this.packCountToday = this.accounting.formatNumber(todayData.packCountToday);
					this.packCountDetailSending = this.accounting.formatNumber(todayData.packCountDetailSending);
					this.packCountSending = this.accounting.formatNumber(todayData.packCountSending);
				}).finally(() => {
					this.completeLoadingToday = true;
					this.stopLoading();
				});
			},
			getChartData(type) {
				this.completeLoadingChart = false;
				this.api.get("/api/kpi/order_sales?type=" + type + "&date=" + this.formatTime(new Date())).then(res => {
					if (res.data != undefined && res.data != null) {
						const orderSales = res.data.orderSales;
						const categories = orderSales.map(item => item.x);
						const seriesData = orderSales.map(item => item.y);
						const series = [{
							"name": "销售额",
							"data": seriesData
						}];
						this.topSales = res.data.topSales.map(item => {
							item.totalPrice = this.accounting.formatMoney(item.totalPrice);
							return item;
						});
						this.showColumn("canvasColumn", categories, series);
					}
				}).finally(() => {
					this.completeLoadingChart = true;
					this.stopLoading();
				});
			},
			onClickItem(index) {
				if (this.current !== index) {
					this.current = index;
				}
				this.getChartData(this.getCurrentChartType());
			},
			getCurrentChartType() {
				switch (this.current) {
					case 0:
						return 'today';
						break;
					case 1:
						return 'week';
						break;
					case 2:
						return 'month';
						break;
					case 3:
						return 'year';
						break;
					default:
						return 'today';
				}
			},
			formatTime(date) {
				const year = date.getFullYear();
				const month = date.getMonth() + 1;
				const day = date.getDate();
				return [year, month, day].map(this.formatDateNumber).join('-');
			},
			formatDateNumber(n) {
				const number = n.toString();
				return number[1] ? number : `0${number}`;
			},
			showColumn(canvasId, categories, series) {
				canvaColumn = new uCharts({
					$this: _self,
					canvasId: canvasId,
					type: 'column',
					legend: true,
					fontSize: 11,
					background: '#FFFFFF',
					pixelRatio: _self.pixelRatio,
					animation: true,
					categories,
					series,
					xAxis: {
						disableGrid: true,
					},
					yAxis: {
						//disabled:true
					},
					dataLabel: true,
					width: _self.cWidth * _self.pixelRatio,
					height: _self.cHeight * _self.pixelRatio,
					extra: {
						column: {
							type: 'group',
							width: _self.cWidth * _self.pixelRatio * 0.45 / categories.length
						}
					}
				});
			},
			touchColumn(e) {
				canvaColumn.showToolTip(e, {
					format: function(item, category) {
						if (typeof item.data === 'object') {
							return category + ' ' + item.name + ':' + item.data.value
						} else {
							return category + ' ' + item.name + ':' + item.data
						}
					}
				});
			},
		}
	}
</script>

<style>
	.list-title {
		font-size: 32upx;
		line-height: 32upx;
		color: #777;
		margin: 40upx 25upx;
		position: relative
	}

	.card {
		margin: 30upx;
	}

	.segment {
		margin: 30upx;
		/* #ifdef H5 */
		margin: 30upx auto;
		/* #endif */
	}

	.chart {
		margin-top: 30upx;
		margin-bottom: 50upx;
	}

	.qiun-charts {
		width: 750upx;
		height: 500upx;
		background-color: #FFFFFF;
	}

	.charts {
		width: 750upx;
		height: 500upx;
		background-color: #FFFFFF;
	}
</style>
