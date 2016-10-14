$(document).on 'turbolinks:load', ->
  first_pieChart = $('#first_piechart')
  reserve_pieChart = $('#reserve_piechart')

  first_data = {
    labels: [
      "Win",
      "Drawn",
      "Lost"
    ],
    datasets: [
      {
        data: [first_pieChart.data('win'), first_pieChart.data('drawn'), first_pieChart.data('lost')],
        backgroundColor: [
          "#428bca",
          "#5cb85c",
          "#d9534f"
        ],
        hoverBackgroundColor: [
          "#428bca",
          "#5cb85c",
          "#d9534f"
        ]
      }
    ]
  }

  reserve_data = {
    labels: [
      "Win",
      "Drawn",
      "Lost"
    ],
    datasets: [
      {
        data: [reserve_pieChart.data('win'), reserve_pieChart.data('drawn'), reserve_pieChart.data('lost')],
        backgroundColor: [
          "#428bca",
          "#5cb85c",
          "#d9534f"
        ],
        hoverBackgroundColor: [
          "#428bca",
          "#5cb85c",
          "#d9534f"
        ]
      }
    ]
  }

  myChart = new Chart(first_pieChart, {
    type: 'doughnut',
    data: first_data,
  })

  myChart = new Chart(reserve_pieChart, {
    type: 'doughnut',
    data: reserve_data
  })
