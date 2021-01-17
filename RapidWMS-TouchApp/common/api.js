import md5 from '../plugin/md5/build/md5.min.js'

// const defaultBaseUrl = 'http://127.0.0.1:8016';
const defaultBaseUrl = process.env.NODE_ENV === 'development'?'http://localhost:8016':'http://101.32.201.125';
let _baseUrl = defaultBaseUrl;

const getBaseUrl = () => {
	// if (_baseUrl == null) {
	// 	_baseUrl = uni.getStorageSync('rapidWMS-server-address');
	// }
	// if (_baseUrl == null || _baseUrl == "") {
		setBaseUrl(defaultBaseUrl);
	// }
	return _baseUrl;
}

const setBaseUrl = (url, callback) => {
	_baseUrl = url;
	uni.setStorage({
		key: 'rapidWMS-server-address',
		data: url,
		success: () => {
			callback && callback();
		}
	});
}

const request = (url, data, method) => {
	const token = uni.getStorageSync('jwt-token');
	if (token == null || getBaseUrl() == null) {
		uni.reLaunch({
			url: '/pages/login/login',
			success: () => {
				uni.showToast({
					title: '你需要登录才能继续操作',
					icon: 'none'
				});
			}
		});
		return;
	}
	return new Promise((resolve, reject) => {
		uni.request({
			url: getBaseUrl() + url,
			method,
			data,
			header: {
				"Authorization": "Bearer " + token
			},
			success: (res) => {
				if (res.statusCode == 401) {
					uni.reLaunch({
						url: '/pages/login/login',
						success: () => {
							uni.showToast({
								title: '你需要登录才能继续操作',
								icon: 'none'
							});
						}
					});
				}
				if (res.statusCode == 403) {
					uni.showToast({
						title: '对不起，你的权限不足，无法完成此操作',
						icon: 'none'
					});
				}
				if (res.statusCode == 405) {
					uni.showToast({
						title: '对不起，发生405错误，请检查服务器地址是否正确',
						icon: 'none'
					});
				}
				if (res.statusCode == 400) {
					let msg = res.data.message;
					if (msg == null || msg == '') {
						msg = '未知错误';
					}
					uni.showToast({
						title: msg,
						icon: 'none'
					});
				}
				resolve(res);
			},
			fail: (err) => {
				if (err.errMsg.indexOf("request:fail") == 0) {
					uni.showToast({
						title: '无法连接到服务器',
						icon: 'none',
					});
				}
				reject(err);
			},
			complete: () => {

			}
		});
	});
};

const get = (url) => {
	return request(url, null, 'GET');
}

const post = (url, data) => {
	return request(url, data, 'POST');
}

const put = (url, data) => {
	return request(url, data, 'PUT');
}

const _delete = (url) => {
	return request(url, null, 'DELETE');
}

export default {
	getBaseUrl,
	setBaseUrl,
	get,
	post,
	put,
	_delete,
}
