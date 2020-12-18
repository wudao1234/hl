<template>
	<view>
		<view class="cancel" v-if="packStatus == 'CANCEL'">打包已作废，原因：{{cancelDescription}}</view>
		<view class="complete" v-if="packStatus == 'COMPLETE'">打包已完结</view>
		<view class="title">基本信息</view>
		<uni-list>
			<uni-list-item :show-arrow="false" :title="customerName" />
			<uni-list-item :show-arrow="false" :title="createTime" />
			<uni-list-item :show-arrow="false" :title="flowSn" />
			<uni-list-item :show-arrow="false" :title="packType" />
			<uni-list-item :show-arrow="false" :title="packages" />
			<uni-list-item :show-arrow="false" :title="trackingNumber" />
			<uni-list-item :show-arrow="false" :title="description" />
		</uni-list>
		<view class="title" v-if="pack.address">地址信息</view>
		<uni-list v-if="pack.address">
			<uni-list-item :show-arrow="false" :title="(pack.address.name ? '地址：' + pack.address.name : '')" />
			<uni-list-item :show-arrow="false" :title="(pack.address.contact ? '联系人：' + pack.address.contact : '')" />
			<uni-list-item :show-arrow="false" :title="(pack.address.phone ? '联系电话：' + pack.address.phone : '')" @click="call(pack.address.phone)" />
			<uni-list-item :show-arrow="false" :title="(pack.address.description ? '说明：' + pack.address.description : '')" />
		</uni-list>
		<view class="title">订单明细</view>
		<uni-list>
			<uni-list-item v-for="order in orders" :key="order.id" :show-arrow="true" 
				:title="formatTitle(order.clientName)" 
				clickable
				:note="formatNote(order.flowSn, order.clientStore)"
				:show-badge="true" :badge-text="formatPrice(order.totalPrice)"
				@click="viewOrderDetail(order)" />	
		</uni-list>
		<view class="price_total">
			总金额：<uni-tag class="price_tag" :circle="true" :text="totalPrice" type="primary" size="small" />
		</view>
		<view class="title">分包明细</view>
		<uni-list>
			<uni-list-item v-for="item in packItems" :key="item.id" :show-arrow="false" 
				:title="formatTitle2(item.name, item.number)" 
				:note="formatGoodsNote(item.sn, item.expireDate)"
				:show-badge="true" :badge-text="item.quantity" badge-type="error" />	
		</uni-list>
		<view class="price_total" v-if="packItems.length == 0">
			暂未分配分包信息
		</view>
		<view class="title">操作记录</view>
		<view class="step_area">
			<uni-steps :options="operateSnapshots" :active="active" direction="column" />
		</view>
		<view class="title" v-if="pack.signedPhoto" @error="imageError">签收照片</view>
		<view class="signedPhotoBox" v-if="pack.signedPhoto">
			<image class="signedPhoto" mode="aspectFill" :src="signedPhoto(pack.signedPhoto)" @error="imageError" @click="previewPhoto(pack.signedPhoto)"></image>
		</view>
		<view class="padding flex flex-direction">
			<button class="cu-btn bg-blue lg" :loading="loading" @click="sendingByMe" v-if="packStatus == 'PACKAGE'">我来派送</button>
			<button class="cu-btn bg-mauve margin-tb-sm lg" :loading="loading" @click="packagePack" v-if="packStatus == 'PACKAGE'">箱码分包</button>
			<button class="cu-btn bg-purple lg" :loading="loading" @click="userSigned" v-if="isEdit && packStatus == 'SENDING'">拍照签收</button>
			<button class="cu-btn bg-orange margin-tb-sm lg" :loading="loading" @click="userSignedWithNoPhoto" v-if="isEdit && packStatus == 'SENDING'">不拍照签收</button>
			<button class="cu-btn bg-green lg" :loading="loading" @click="cancelSending" v-if="isEdit && packStatus == 'SENDING'">退回待发</button>
			<button class="cu-btn bg-cyan margin-tb-sm lg" :loading="loading" @click="reUploadPhoto" v-if="packStatus == 'CLIENT_SIGNED' || packStatus == 'COMPLETE'">重传照片</button>
			<button class="cu-btn bg-red lg" :loading="loading" @click="cancelPack" v-if="!isEdit && packStatus != 'CANCEL'">作废打包</button>
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
	</view>
</template>

<script>
	import {uniList, uniListItem, uniSteps, uniTag} from '@dcloudio/uni-ui'
	
	export default {
		components: {uniList, uniListItem, uniSteps, uniTag},
		data() {
			return {
				isEdit: false,
				pack: { address: {}, customer: {}, operateSnapshots:[], orders:[], packItems:[]},
				customerName: '',
				createTime: '',
				totalPrice: '',
				description: '',
				flowSn: '',
				trackingNumber: '',
				packType: '',
				packages: '',
				orders: [],
				operateSnapshots: [],
				packItems: [],
				packStatus: '',
				loading: false,
				showModal: false,
				cancelDescription: '',
				packId: '',
			}
		},
		computed: {
			signedPhoto() {
				return (photoPath) => {
					return this.api.getBaseUrl() + photoPath;
				}
			},
			formatTitle() {
				return (name) => {
					return name;
				}
			},
			formatTitle2() {
				return (name, number) => {
					return '#' + number + ' ' + name;
				}
			},
			formatNote() {
				return (flowSn, address) => {
					return `${flowSn} | ${address}`;
				}
			},
			formatGoodsNote() {
				return (sn, expireDate) => {
					return `${sn} | ${this.moment(expireDate).format("YYYY-MM-DD")}`;
				}
			},
			formatPrice() {
				return (price) => {
					return this.accounting.formatMoney(price);
				}
			},
			active() {
				return this.operateSnapshots.length - 1;
			},
		},
		methods: {
			loadPackDetail(id) {
				this.api.get(`/api/packs/${id}`).then(res => {
					const pack = res.data;
					this.pack = pack;
					this.customerName = "客户：" + pack.customer.name;
					this.totalPrice = this.accounting.formatMoney(pack.totalPrice);
					this.createTime = "创建时间：" + this.moment(pack.createTime).format("YYYY-MM-DD HH:mm");
					this.description = "说明：" + (pack.description ? pack.description : '');
					this.flowSn = "流水号：" + pack.flowSn;
					this.trackingNumber = "物流单号：" + (pack.trackingNumber ? pack.trackingNumber : '');
					this.packType = "打包类型：" + this.getPackTypeText(pack.packType);
					this.packages = "件数：" + pack.packages;
					
					this.orders = pack.orders;					
					this.packStatus = pack.packStatus;
					this.cancelDescription = pack.cancelDescription == null ? '' : pack.cancelDescription;
					this.packItems = pack.packItems.sort((a, b) => a.number - b.number);
					this.operateSnapshots = pack.operateSnapshots.map(item => {
						return {
							title: `${item.operation} - ${item.operator}`,
							desc: this.moment(item.createTime).format("YYYY-MM-DD HH:mm"),
						}
					});
				});
			},
			getPackTypeText(type) {
				switch (type){
					case 'SENDING':
						return '市区派送';
						break;
					case 'TRANSFER':
						return '外发物流';
						break;
					case 'SELF_PICKUP':
						return '自行提取';
						break;
					default:
						return '未知类型';
						break;
				}
			},
			hideModal() {
				this.showModal = false;
			},
			packagePack() {
				uni.navigateTo({
					url: `../pack-package/pack-package?id=${this.packId}`,
					animationType: 'slide-in-right',
				});
			},
			sendingByMe() {
				uni.showModal({
					title: '确认对话框',
					content: '确认派送此包？',
					success: res => {
						if (res.confirm) {
							this.loading = true;
							this.api.post('/api/packs/sendingByMe', {
								ids: [this.packId],
							}).then(res => {
								if (res.statusCode == 201) {
									uni.showToast({
										title: '受领成功',
										icon: 'success',
										success: () => {
											setTimeout(() => {
												uni.$emit('updatePackList', this.packId);
												uni.navigateBack();
											}, 1000);
										}
									});
								} else {
									this.loading = false;
								}
							});
						}
					}
				});
			},
			cancelSending() {
				uni.showModal({
					title: '确认对话框',
					content: '确认退回此包？',
					success: res => {
						if (res.confirm) {
							this.loading = true;
							this.api.post('/api/packs/return/' + this.packId).then(res => {
								if (res.statusCode == 201) {
									uni.showToast({
										title: '退回成功',
										icon: 'success',
										success: () => {
											setTimeout(() => {
												uni.$emit('updatePackList', this.packId);
												uni.navigateBack();
											}, 1000);
										}
									});
								} else {
									this.loading = false;
								}
							});
						}
					}
				});
			},
			userSigned() {
				this.loading = true;
				uni.chooseImage({
					count: 1,
					success: (chooseImageRes) => {
						const tempFilePaths = chooseImageRes.tempFilePaths;
						uni.uploadFile({
							url: this.api.getBaseUrl() + '/api/packs/upload_picture',
							filePath: tempFilePaths[0],
							name: 'file',
							header: {"Authorization": "Bearer " + uni.getStorageSync('jwt-token')},
							success: (res) => {
								this.api.post("/api/packs/signed/" + this.packId + "?uploadFile=" + res.data).then(res => {
									if (res.statusCode == 201) {
										uni.showToast({
											title: '签收成功',
											icon: 'success',
											success: () => {
												this.loading = false;
												setTimeout(() => {
													uni.$emit('updatePackList', this.packId);
													uni.navigateBack();
												}, 1000);
											}
										});
									}
								});
							},
							fail: (err) => {
								uni.showModal({
									title: '请选择',
									content: '上传失败或没有选择图片，是否继续签收？',
									showCancel: true,
									confirmText: '签收',
									success: res => {
										if (res.confirm) {
											this.api.post("/api/packs/signed/" + this.packId).then(res => {
												if (res.statusCode == 201) {
													uni.showToast({
														title: '签收成功',
														icon: 'success',
														success: () => {
															this.loading = false;
															setTimeout(() => {
																uni.$emit('updatePackList', this.packId);
																uni.navigateBack();
															}, 1000);
														}
													});
												}
											});
										}
									}
								});
							}
						});
					},
					fail: () => {
						this.loading = false;
					},
					complete: () => {
						this.loading = false;
					}
				});
			},
			userSignedWithNoPhoto() {
				uni.showModal({
					title: '确认签收',
					content: '照片可以后续再上传，是否继续签收？',
					showCancel: true,
					confirmText: '签收',
					success: res => {
						if (res.confirm) {
							this.api.post("/api/packs/signed/" + this.packId).then(res => {
								if (res.statusCode == 201) {
									uni.showToast({
										title: '签收成功',
										icon: 'success',
										success: () => {
											this.loading = false;
											setTimeout(() => {
												uni.$emit('updatePackList', this.packId);
												uni.navigateBack();
											}, 1000);
										}
									});
								}
							});
						}
					}
				});
			},
			cancelPack() {
				this.showModal = true;
			},
			confirmCancel() {
				if (this.cancelDescription.length > 0) {
					this.showModal = false;
					uni.hideKeyboard();
					this.loading = true;
					this.api.post("/api/packs/cancel/" + this.packId + "?description=" + this.cancelDescription).then(res => {
						if (res.statusCode == 201) {
							uni.showToast({
								title: '作废成功',
								icon: 'success',
								success: () => {
									setTimeout(() => {
										uni.$emit('updatePackList', this.packId);
										uni.navigateBack();
									}, 1000);
								}
							});
						}						
					}).finally(() => {
						this.loading = false;
					})
				}
			},
			reUploadPhoto() {
				this.loading = true;
				uni.chooseImage({
					count: 1,
					success: (chooseImageRes) => {
						const tempFilePaths = chooseImageRes.tempFilePaths;
						uni.uploadFile({
							url: this.api.getBaseUrl() + '/api/packs/' + this.packId + '/changeSignedPhoto',
							filePath: tempFilePaths[0],
							name: 'file',
							header: {"Authorization": "Bearer " + uni.getStorageSync('jwt-token')},
							success: (res) => {
								console.log(res);
								if (res.statusCode == 201) {
									uni.showToast({
										title: '上传成功',
										icon: 'success',
										success: () => {
											this.loading = false;
											setTimeout(() => {
												uni.navigateBack();
											}, 1000);
										}
									});
								} else {
									uni.showToast({
									title: '上传失败，上传文件请不要太大',
									icon: 'none',
								});
								}
							},
							fail: (err) => {
								uni.showToast({
									title: '上传失败',
									icon: 'none',
								});
							}
						});
					},
					fail: () => {
						this.loading = false;
					},
					complete: () => {
						this.loading = false;
					}
				});
			},
			call(phone) {
				if (!isNaN(phone)) {
					uni.makePhoneCall({
						phoneNumber: phone,
					});
				}
			},
			imageError(e) {
				uni.showToast({
					title: '加载图片出错',
					icon: 'none',
				});
			},
			previewPhoto(imgUrl) {
				uni.previewImage({
					urls: [this.api.getBaseUrl() + imgUrl],
					longPressActions: {
					itemList: ['保存图片'],
						success: (res) => {
							uni.saveImageToPhotosAlbum({
								filePath: this.api.getBaseUrl() + imgUrl,
								success: () => {
									uni.showToast({
										title: '保存成功',
										icon: 'success',
									});
								},
								fail: () => {
									uni.showToast({
										title: '保存失败',
										icon: 'none',
									});
								}
							});
						} 
					}
				});
			},
			viewOrderDetail(order) {
				uni.navigateTo({
					url: `../order-confirm/order-confirm?id=${order.id}`,
					animationType: 'slide-in-right',
				});
			}
		},
		onLoad(params) {
			this.packId = params.id;
			this.isEdit = params.isEdit;
			this.loadPackDetail(this.packId);
			uni.$on('updatePackDetail', () => {
				this.loadPackDetail(this.packId);
			});
		},
		onUnload() {
			uni.$off('updatePackDetail');
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
	.signedPhotoBox {
		display: flex;
		justify-content: center;
		align-items: center;
		width: 750upx;
		height: 300upx;
		background-color: #FFFFFF;
	}
	.signedPhoto {
		width: 300upx;
		height: 300upx;
		padding: 30upx;
	}
</style>
