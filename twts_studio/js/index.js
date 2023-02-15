/*
* 2023-02-15
* wangZhiAng
* */

//侧边栏时间倒计时
function time() {
    let now = +new Date();
    let off = +new Date('2022-07-20 00:00:00')
    // 计算时间差
    let times = now - off;
    // 将时间戳转换为毫秒
    times = times / 1000;
    //  计算天数
    let d = parseInt(times / 60 / 60 / 24 + '');
    //   计算小时
    let h = parseInt(times / 60 / 60 % 24 + '');
    h = h < 10 ? '0' + h : h;
    //   计算分数
    let m = parseInt(times / 60 % 60 + '');
    m = m < 10 ? '0' + m : m;
    //   计算当前秒数
    let s = parseInt(times % 60 + '');
    s = s < 10 ? '0' + s : s;
    let div = document.querySelector('#box');
    div.innerHTML = `<span>${d}</span>天<span>${h}</span>小时<span>${m}</span>分钟<span>${s}</span>秒 `;
}

// 调用函数
time();
// 开启定时器
setInterval(function () {
    time();
}, 1000)