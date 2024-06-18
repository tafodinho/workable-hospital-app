// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "flowbite";

// app/assets/javascripts/patients.js

document.addEventListener("turbo:load", function () {
  main();
});

const main = () => {
  let chart = null;
  const columnChart = document.getElementById("column-chart");
  if (columnChart) {
    const data = JSON.parse(columnChart.dataset.chartData);

    const options = {
      colors: ["#1A56DB", "#FDBA8C"],
      grid: {
        show: true,
        strokeDashArray: 4,
        padding: {
          left: 2,
          right: 2,
          top: -26,
        },
      },
      series: [
        {
          name: "Patients",
          color: "#1A56DB",
          data: data,
        },
      ],
      chart: {
        type: "bar",
        height: "100%",
        maxWidth: "100%",
        fontFamily: "Inter, sans-serif",
        zoom: {
          enabled: true,
        },
        toolbar: {
          show: false,
        },
      },
      plotOptions: {
        bar: {
          horizontal: false,
          columnWidth: "70%",
          borderRadiusApplication: "end",
          borderRadius: 8,
        },
      },
      tooltip: {
        shared: true,
        intersect: false,
        style: {
          fontFamily: "Inter, sans-serif",
        },
      },
      states: {
        hover: {
          filter: {
            type: "darken",
            value: 1,
          },
        },
      },
      stroke: {
        show: true,
        width: 0,
        colors: ["transparent"],
      },
      grid: {
        show: true,
        strokeDashArray: 4,
        padding: {
          left: 2,
          right: 2,
          top: -14,
        },
      },
      dataLabels: {
        enabled: false,
      },
      legend: {
        show: false,
      },
      xaxis: {
        type: "datetime",
        labels: {
          format: "dd MMM",
        },
        axisBorder: {
          show: true,
        },
        axisTicks: {
          show: true,
        },
      },
      yaxis: {
        show: true,
        labels: {
          show: true,
          style: {
            fontFamily: "Inter, sans-serif",
            cssClass: "text-xs font-normal fill-gray-500 dark:fill-gray-400",
          },
          formatter: function (value) {
            return value;
          },
        },
      },
      fill: {
        opacity: 0.5,
      },
    };

    if (columnChart && typeof ApexCharts !== "undefined") {
      chart = new ApexCharts(columnChart, options);
      chart.render();
    }
  }

  initializeDropdown(chart);
};

function initializeDropdown(chart) {
  const mainButton = document.getElementById("dropdownDefaultButton");
  const dropdownButtons = document.querySelectorAll("#lastDaysdropdown button");

  dropdownButtons.forEach((button) => {
    button.addEventListener("click", (event) => {
      const value = event.currentTarget.getAttribute("data-value");
      const text = event.currentTarget.textContent;

      // Update the main button text and value
      mainButton.innerHTML = `${text.trim()} <svg class="w-2.5 m-2.5 ms-1.5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 10 6"><path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 4 4 4-4"/></svg>`;
      mainButton.setAttribute("value", value);

      // You can also make an API request or perform any action you need with the selected value
      console.log("Selected value:", value);

      // Hide the dropdown
      fetch("http://localhost:3000/dashboard", {
        method: "POST",
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
          "X-CSRF-Token": document
            .querySelector('meta[name="csrf-token"]')
            .getAttribute("content"),
        },
        body: JSON.stringify({ days: value }),
      })
        .then((response) => {
          console.log("RESPONSE".response);
          return response.json();
        })
        .then((data) => {
          // Update the chart with new data
          console.log("DATA", data);
          chart.updateSeries([{ data }]);
        })
        .catch((error) => {
          console.error("Error fetching data:", error);
        });

      document.getElementById("lastDaysdropdown").classList.add("hidden");
    });
  });
}

function initializeSearchForm() {
  const searchButton = document.getElementById("search-button");
  const searchInput = document.getElementById("search-input");
  const csrfToken = document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute("content");

  if (searchButton) {
    searchButton.addEventListener("click", function (event) {
      event.preventDefault();
      const query = searchInput.value;
      const url = `/patients?search=${query}`;
      fetch(url, {
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
        },
        credentials: "same-origin",
      })
        .then((response) => response.text())
        .then((data) => {})
        .catch((error) => console.error("Error:", error));
    });
  }
}
