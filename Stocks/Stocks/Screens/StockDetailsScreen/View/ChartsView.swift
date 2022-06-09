//
//  ChartsView.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 07.06.2022.
//

import UIKit
import Charts

final class ChartsContainerView: UIView {

	private lazy var chartsView: LineChartView = {
		let view = LineChartView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.xAxis.drawLabelsEnabled = false
		view.leftAxis.enabled = false
		view.leftAxis.drawGridLinesEnabled = false
		view.rightAxis.enabled = false
		view.rightAxis.drawGridLinesEnabled = false
		view.backgroundColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
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
		addButtons(for: model.periods.map { $0.name })
		setCharts(with: model.periods.first?.prices)  
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

		addButtons(for: ["W", "M", "6M", "1Y"])

		chartsView.addSubview(loader)

		loader.centerXAnchor.constraint(equalTo: chartsView.centerXAnchor).isActive = true
		loader.centerYAnchor.constraint(equalTo: chartsView.centerYAnchor).isActive = true
	}

	private func addButtons(for titles: [String]){
		titles.enumerated().forEach{ (index, title) in
			let button = UIButton()
			button.tag = index
			button.backgroundColor = .chartsButtonColor
			button.setTitle(title, for: .normal)
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
		print("Button index - ", sender.tag)
	}

	private func setCharts(with prices: [Double]?) {
		guard let prices = prices else {
			return
		}
		var yValues = [ChartDataEntry]()
		for (index, value) in prices.enumerated(){
			let dataEntry = ChartDataEntry(x: Double(index + 1), y: value)
			yValues.append(dataEntry)
		}

		let lineDataSet = LineChartDataSet(entries: yValues, label: "$")
		lineDataSet.valueFont = .boldSystemFont(ofSize: 10)
		lineDataSet.valueTextColor = .white
		lineDataSet.drawFilledEnabled = true
		lineDataSet.circleRadius = 3.0
		lineDataSet.circleHoleRadius = 2.0

		chartsView.data = LineChartData(dataSets: [lineDataSet])
		chartsView.animate(xAxisDuration: 0.3, yAxisDuration: 0.2)
	}
}

