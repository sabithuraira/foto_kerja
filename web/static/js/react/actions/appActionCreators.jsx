import * as types from '../constants/appConstants'

export const listPhoto = (search_keyword, datas) => ({ 
    type: types.LIST_PHOTO, 
    search_keyword, datas 
})

export const showDetail = (is_show) => ({ 
    type: types.SHOW_DETAIL,
    is_show
})

export const setDetail = (data) => ({ 
    type: types.SET_DETAIL,
    data
})

export const listComment = (comments) => ({ 
    type: types.LIST_COMMENT,
    comments
})

//export const listData= (id) => ({ type: types.LIST_DATA, id })