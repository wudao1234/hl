import memoizeOne from 'memoize-one';
import isEqual from 'lodash/isEqual';
// import { formatMessage } from 'umi/locale';
import Authorized from '@/utils/Authorized';
// import { menu } from '../defaultSettings';
import { queryCurrentMenus } from '../services/sysMenu';

const { check } = Authorized;

// Conversion router to menu.
/*
function formatter(data, parentAuthority, parentName) {
  return data
    .map(item => {
      if (!item.name || !item.path) {
        return null;
      }

      let locale = 'menu';
      if (parentName) {
        locale = `${parentName}.${item.name}`;
      } else {
        locale = `menu.${item.name}`;
      }
      // if enableMenuLocale use item.name,
      // close menu international
      const name = menu.disableLocal
        ? item.name
        : formatMessage({ id: locale, defaultMessage: item.name });
      const result = {
        ...item,
        name,
        locale,
        authority: item.authority || parentAuthority,
      };
      if (item.routes) {
        const children = formatter(item.routes, item.authority, locale);
        // Reduce memory usage
        result.children = children;
      }
      delete result.routes;
      return result;
    })
    .filter(item => item);
}
*/
// const memoizeOneFormatter = memoizeOne(formatter, isEqual);

/**
 * get SubMenu or Item
 */
const getSubMenu = item => {
  // doc: add hideChildrenInMenu
  if (item.children && !item.hideChildrenInMenu && item.children.some(child => child.name)) {
    return {
      ...item,
      children: filterMenuData(item.children), // eslint-disable-line
    };
  }
  return item;
};

/**
 * filter menuData
 */
const filterMenuData = menuData => {
  if (!menuData) {
    return [];
  }
  return menuData
    .filter(item => item.name && !item.hideInMenu)
    .map(item => check(item.authority, getSubMenu(item)))
    .filter(item => item);
};
/**
 * 获取面包屑映射
 * @param {Object} menuData 菜单配置
 */
const getBreadcrumbNameMap = menuData => {
  const routerMap = {};

  const flattenMenuData = data => {
    data.forEach(menuItem => {
      if (menuItem.children) {
        flattenMenuData(menuItem.children);
      }
      // Reduce memory usage
      routerMap[menuItem.path] = menuItem;
    });
  };
  flattenMenuData(menuData);
  return routerMap;
};

const mapMetaIconToMenu = menuData => {
  return menuData.map(item => {
    if (item.children) {
      return { ...item, icon: item.meta.icon, children: mapMetaIconToMenu(item.children) };
    }
    return { ...item, icon: item.meta.icon };
  });
};

const addLocaleToBreadcrumb = breadcrumb => {
  const result = {};
  Object.keys(breadcrumb).forEach(key => {
    if (!breadcrumb[key].children) {
      result[key] = { ...breadcrumb[key], locale: breadcrumb[key].name };
    }
  });
  return result;
};

const memoizeOneGetBreadcrumbNameMap = memoizeOne(getBreadcrumbNameMap, isEqual);

export default {
  namespace: 'menu',

  state: {
    menuData: [],
    routerData: [],
    breadcrumbNameMap: {},
  },

  effects: {
    *getMenuData({ payload }, { call, put }) {
      // const { routes, authority } = payload;
      // const originalStaticMenuData = memoizeOneFormatter(routes, authority);
      const { routes } = payload;
      const originalMenuData = yield call(queryCurrentMenus);
      const menuData = mapMetaIconToMenu(filterMenuData(originalMenuData));
      const breadcrumbNameMap = addLocaleToBreadcrumb(memoizeOneGetBreadcrumbNameMap(menuData));
      // console.log(breadcrumbNameMap);
      // console.log(menuData);
      // console.log(filterMenuData(originalStaticMenuData));
      yield put({
        type: 'save',
        payload: { menuData, breadcrumbNameMap, routerData: routes },
      });
    },
  },

  reducers: {
    save(state, action) {
      return {
        ...state,
        ...action.payload,
      };
    },
  },
};
