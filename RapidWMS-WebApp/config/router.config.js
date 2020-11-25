export default [
  // user
  {
    path: '/user',
    component: '../layouts/UserLayout',
    routes: [
      { path: '/user', redirect: '/user/login' },
      { path: '/user/login', name: 'login', component: './User/Login' },
    ],
  },
  // app
  {
    path: '/',
    component: '../layouts/BasicLayout',
    Routes: ['src/pages/Authorized'],
    routes: [
      // dashboard
      { path: '/', redirect: '/dashboard/analysis' },
      {
        path: '/dashboard',
        name: 'dashboard',
        icon: 'dashboard',
        routes: [
          {
            path: '/dashboard/analysis',
            name: 'analysis',
            component: './Dashboard/Analysis',
          },
          {
            path: '/dashboard/unsales',
            name: 'analysis',
            component: './Dashboard/UnSales',
          },
          {
            path: '/dashboard/monitor',
            name: 'monitor',
            component: './Dashboard/Monitor',
          },
          {
            path: '/dashboard/workplace',
            name: 'workplace',
            component: './Dashboard/Workplace',
          },
        ],
      },
      // system
      {
        path: '/system',
        icon: 'setting',
        name: 'system',
        routes: [
          {
            path: '/system/user',
            icon: 'user',
            name: 'user',
            component: './User/User',
          },
          {
            path: '/system/role',
            icon: 'team',
            name: 'role',
            component: './Role/Role',
          },
          {
            path: '/system/permission',
            icon: 'solution',
            name: 'permission',
            component: './Permission/Permission',
          },
          {
            path: '/system/menu',
            icon: 'solution',
            name: 'menu',
            component: './SysMenu/SysMenu',
          },
          {
            path: '/system/job',
            icon: 'job',
            name: 'job',
            component: './Job/Job',
          },
          {
            path: '/system/profile',
            icon: 'user',
            name: 'profile',
            component: './MyProfile/MyProfile',
            routes: [
              {
                path: '/system/profile',
                redirect: '/system/profile/base',
              },
              {
                path: '/system/profile/base',
                component: './MyProfile/BaseView',
              },
              {
                path: '/system/profile/security',
                component: './MyProfile/SecurityView',
              },
            ],
          },
        ],
      },
      {
        name: 'monitor',
        icon: 'monitor',
        path: '/monitor',
        routes: [
          // exception
          {
            path: '/monitor/log',
            name: 'log',
            component: './Log/Log',
          },
          {
            path: '/monitor/error',
            name: 'error',
            component: './LogError/LogError',
          },
          {
            path: '/monitor/jobLog',
            name: 'jobLog',
            component: './JobLog/JobLog',
          },
          {
            path: '/monitor/redis',
            name: 'redis',
            component: './Redis/Redis',
          },
          {
            path: '/monitor/console',
            name: 'console',
            component: './Console/Console',
          },
        ],
      },
      {
        name: 'infrastructure',
        icon: 'infrastructure',
        path: '/infrastructure',
        routes: [
          {
            path: '/infrastructure/customer',
            name: 'customer',
            component: './Customer/Customer',
          },
          {
            path: '/infrastructure/wareZone',
            name: 'wareZone',
            component: './WareZone/WareZone',
          },
          {
            path: '/infrastructure/warePosition',
            name: 'warePosition',
            component: './WarePosition/WarePosition',
          },
          {
            path: '/infrastructure/goods',
            name: 'goods',
            component: './Goods/Goods',
          },
          {
            path: '/infrastructure/goodsType',
            name: 'goodsType',
            component: './GoodsType/GoodsType',
          },
          {
            path: '/infrastructure/address',
            name: 'address',
            component: './Address/Address',
          },
          {
            path: '/infrastructure/addressType',
            name: 'addressType',
            component: './AddressType/AddressType',
          },
          {
            path: '/infrastructure/store',
            name: 'store',
            component: './Store/Store',
          },
        ],
      },
      {
        name: 'warehouse',
        icon: 'warehouse',
        path: '/warehouse',
        routes: [
          {
            path: '/warehouse/stock',
            name: 'stock',
            component: './Stock/Stock',
          },
          {
            path: '/warehouse/receiveGoods',
            name: 'receiveGoods',
            component: './ReceiveGoods/ReceiveGoods',
          },
          {
            path: '/warehouse/addReceiveGoods',
            name: 'addReceiveGoods',
            component: './ReceiveGoods/AddReceiveGoods',
          },
          {
            path: '/warehouse/editReceiveGoods/:id',
            name: 'editReceiveGoods',
            component: './ReceiveGoods/EditReceiveGoods',
            hideInMenu: true,
          },
          {
            path: '/warehouse/auditReceiveGoods/:id',
            name: 'auditReceiveGoods',
            component: './ReceiveGoods/AuditReceiveGoods',
            hideInMenu: true,
          },
          {
            path: '/warehouse/viewReceiveGoods/:id',
            name: 'viewReceiveGoods',
            component: './ReceiveGoods/ViewReceiveGoods',
            hideInMenu: true,
          },
          {
            path: '/warehouse/stockFlow',
            name: 'stockFlow',
            component: './StockFlow/StockFlow',
          },
        ],
      },
      {
        name: 'order',
        icon: 'order',
        path: '/order',
        routes: [
          {
            path: '/order/order',
            name: 'order',
            component: './Order/Order',
          },
          {
            path: '/order/addOrder',
            name: 'addOrder',
            component: './Order/AddOrder',
          },
          {
            path: '/order/editOrder/:id',
            name: 'editOrder',
            component: './Order/EditOrder',
            hideInMenu: true,
          },
          {
            path: '/order/viewOrder/:id',
            name: 'viewOrder',
            component: './Order/ViewOrder',
            hideInMenu: true,
          },
          {
            path: '/order/importOrder',
            name: 'importOrder',
            component: './Order/ImportOrder',
          },
          {
            path: '/order/stockFlow',
            name: 'stockFlow',
            component: './StockFlow/OrderStockFlow',
          },
          {
            path: '/order/completeOrder',
            name: 'completeOrder',
            component: './Order/CompleteOrder',
          },
        ],
      },
      {
        name: 'transit',
        icon: 'transit',
        path: '/transit',
        routes: [
          {
            path: '/transit/confirmOrder',
            name: 'transit',
            component: './ConfirmOrder/Order',
          },
          {
            path: '/transit/viewOrder/:id',
            name: 'viewOrder',
            component: './ConfirmOrder/ViewOrder',
            hideInMenu: true,
          },
          {
            path: '/transit/pack',
            name: 'transit',
            component: './Pack/Pack',
          },
          {
            path: '/transit/addPack',
            name: 'addPack',
            component: './Pack/AddPack',
          },
          {
            path: '/transit/editPack/:id',
            name: 'editPack',
            component: './Pack/EditPack',
            hideInMenu: true,
          },
          {
            path: '/transit/assignPack/:id',
            name: 'assignPack',
            component: './Pack/AssignPack',
            hideInMenu: true,
          },
          {
            path: '/transit/viewPack/:id',
            name: 'viewPack',
            component: './Pack/ViewPack',
            hideInMenu: true,
          },
        ],
      },
      {
        name: 'exception',
        icon: 'warning',
        path: '/exception',
        routes: [
          // exception
          {
            path: '/exception/403',
            name: 'not-permission',
            component: './Exception/403',
          },
          {
            path: '/exception/404',
            name: 'not-find',
            component: './Exception/404',
          },
          {
            path: '/exception/500',
            name: 'server-error',
            component: './Exception/500',
          },
          {
            path: '/exception/trigger',
            name: 'trigger',
            hideInMenu: true,
            component: './Exception/TriggerException',
          },
        ],
      },
      {
        component: '404',
      },
    ],
  },
];