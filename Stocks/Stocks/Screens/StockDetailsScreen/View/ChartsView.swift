//
//  ChartsView.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 07.06.2022.
//

import UIKit
import Charts

final class ChartsContainerView: UIView {
	private var periods: [ChartsModel.Period] = []

	private lazy var chartsView: LineChartView = {
		let view = LineChartView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.xAxis.drawLabelsEnabled = false
		view.xAxis.drawGridLinesEnabled = false
		view.leftAxis.enabled = false
		view.leftAxis.drawGridLinesEnabled = false
		view.rightAxis.enabled = false
		view.rightAxis.drawGridLinesEnabled = false
		view.chartDescription?.enabled = false
		view.xAxis.drawAxisLineEnabled = false
		view.drawBordersEnabled = false
		view.legend.form = .none

		view.backgroundColor = .white
		return view
	}()

	private lazy var buttonsStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.distribution = .fillEqually
		stackView.spacing = 10
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()

	private lazy var loader: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(with isLoading: Bool){
		isLoading ? loader.startAnimating() : loader.stopAnimating()
		loader.isHidden = !isLoading
		buttonsStackView.isHidden = isLoading
	}

	func configure(with model: ChartsModel){
		addButtons(for: model)
		setCharts(with: model.periods.first)
		periods = model.periods
	}

	private func setupViews(){
		addSubview(chartsView)
		addSubview(buttonsStackView)

		NSLayoutConstraint.activate([
			chartsView.leadingAnchor.constraint(equalTo: leadingAnchor),
			chartsView.trailingAnchor.constraint(equalTo: trailingAnchor),
			chartsView.topAnchor.constraint(equalTo: topAnchor),
			chartsView.heightAnchor.constraint(equalTo: chartsView.widthAnchor, multiplier: 26/36),

			buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			buttonsStackView.topAnchor.constraint(equalTo: chartsView.bottomAnchor, constant: 40),
			buttonsStackView.heightAnchor.constraint(equalToConstant: 44),
			buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])

		chartsView.addSubview(loader)

		loader.centerXAnchor.constraint(equalTo: chartsView.centerXAnchor).isActive = true
		loader.centerYAnchor.constraint(equalTo: chartsView.centerYAnchor).isActive = true
	}

	private func addButtons(for model: ChartsModel){
		model.periods.enumerated().forEach{ (index, period) in
			let button = UIButton()
			button.tag = index
			button.backgroundColor = .chartsButtonColor
			button.setTitle(period.name, for: .normal)
			button.setTitleColor(.black, for: .normal)
			button.titleLabel?.font = .boldSystemFont(ofSize: 12)
			button.layer.cornerRadius = 12
			button.layer.cornerCurve = .continuous
			button.addTarget(self, action: #selector(periodButtonTapped), for: .touchUpInside)
			buttonsStackView.addArrangedSubview(button)
		}
	}

	@objc private func periodButtonTapped(sender: UIButton){
		buttonsStackView.subviews.compactMap { $0 as? UIButton }.forEach{ button in
			button.backgroundColor = .chartsButtonColor
			button.setTitleColor(.black, for: .normal)
		}
		sender.backgroundColor = .black
		sender.setTitleColor(.white, for: .normal)

		switch sender.titleLabel?.text {
		case "W":
			setCharts(with: periods.filter{ $0.name ==  "W"}.first)
		case "M":
			setCharts(with: periods.filter{ $0.name ==  "M"}.first)
		case "6M":
			setCharts(with: periods.filter{ $0.name ==  "6M"}.first)
		case "1Y":
			setCharts(with: periods.filter{ $0.name ==  "1Y"}.first)
		default:
			setCharts(with: periods.first)
		}
	}

	private func setCharts(with period: ChartsModel.Period?) {
		guard let period = period else {
			return
		}
		
		var yValues = [ChartDataEntry]()
		for (index, value) in period.prices.enumerated() {
			let dataEntry = ChartDataEntry(x: Double(index + 1), y: value)
			yValues.append(dataEntry)
		}

		let lineDataSet = LineChartDataSet(entries: yValues, label: "$")
		lineDataSet.valueFont = .systemFont(ofSize: 10)
		lineDataSet.valueTextColor = .gray
		lineDataSet.drawFilledEnabled = true
		lineDataSet.circleRadius = 1.0
		lineDataSet.circleHoleRadius = 0.5
		lineDataSet.setColor(.black)
		lineDataSet.fill = Fill(color: UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.9))
		lineDataSet.drawFilledEnabled = true
		lineDataSet.mode = .cubicBezier
		lineDataSet.lineWidth = 3

		chartsView.data = LineChartData(dataSets: [lineDataSet])
		chartsView.animate(xAxisDuration: 0.6, yAxisDuration: 0.4)
	}
}

