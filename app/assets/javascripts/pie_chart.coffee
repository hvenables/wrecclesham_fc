guarded_ready ->
  firstPieChart = $('#first_piechart')

  if firstPieChart.length > 0
    firstData = {
      labels: [
        "Win",
        "Drawn",
        "Lost"
      ],
      datasets: [
        {
          data: [firstPieChart.data('win'), firstPieChart.data('drawn'), firstPieChart.data('lost')],
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

    myChart = new Chart(firstPieChart, {
      type: 'doughnut',
      data: firstData
    })

  reservePieChart = $('#reserve_piechart')

  if reservePieChart.length > 0
    reserveData = {
      labels: [
        "Win",
        "Drawn",
        "Lost"
      ],
      datasets: [
        {
          data: [reservePieChart.data('win'), reservePieChart.data('drawn'), reservePieChart.data('lost')],
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

    myChart = new Chart(reservePieChart, {
      type: 'doughnut',
      data: reserveData
    })
