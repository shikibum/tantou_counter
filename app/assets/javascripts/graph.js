$(function () {
  const chartData = $('.chart-data').data('chart');
  $('#container').highcharts({
    chart: {
      type: 'bar'
    },
    title: {
      text: '刀種結果'
    },
    xAxis: {
      visible: false
    },
    yAxis: {
      min: 0,
      title: {
        text: ''
      }
    },
    legend: {
      reversed: true
    },
    plotOptions: {
      series: {
        stacking: 'percent',
        dataLabels: {
          enabled: true,
          formatter: function () {
            return this.percentage.toFixed(1) + '%';
          }
        },
      }
    },
    credits: {
      enabled: false
    },
    exporting: {
      enabled: false
    },
    series: chartData
  });
});
