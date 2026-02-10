import 'package:flutter/material.dart';

void main() {
  runApp(const FinancialApp());
}

class FinancialApp extends StatelessWidget {
  const FinancialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        useMaterial3: true,
      ),
      home: const FinancialDashboard(),
    );
  }
}

class Transaction {
  final String title;
  final String date;
  final double amount;
  final bool isExpense;
  final IconData icon;
  final Color color;

  Transaction({
    required this.title,
    required this.date,
    required this.amount,
    required this.isExpense,
    required this.icon,
    required this.color,
  });
}

class FinancialCategory {
  final String name;
  final double amount;
  final IconData icon;
  final Color color;

  FinancialCategory({
    required this.name,
    required this.amount,
    required this.icon,
    required this.color,
  });
}

class FinancialDashboard extends StatefulWidget {
  const FinancialDashboard({super.key});

  @override
  State<FinancialDashboard> createState() => _FinancialDashboardState();
}

class _FinancialDashboardState extends State<FinancialDashboard> {
  final List<Transaction> transactions = [
    Transaction(
      title: 'Isha Patel',
      date: 'Feb 01, 2026',
      amount: 5500.00,
      isExpense: false,
      icon: Icons.account_balance_wallet,
      color: Colors.green,
    ),
    Transaction(
      title: 'Meesho',
      date: 'Feb 03, 2026',
      amount: 120.50,
      isExpense: true,
      icon: Icons.shopping_cart,
      color: Colors.orange,
    ),
    Transaction(
      title: 'Torrent Power',
      date: 'Feb 05, 2026',
      amount: 85.00,
      isExpense: true,
      icon: Icons.flash_on,
      color: Colors.red,
    ),
    Transaction(
      title: 'Myntra',
      date: 'Feb 07, 2026',
      amount: 800.00,
      isExpense: false,
      icon: Icons.work,
      color: Colors.green,
    ),
    Transaction(
      title: 'Nykaa',
      date: 'Feb 08, 2026',
      amount: 65.00,
      isExpense: true,
      icon: Icons.restaurant,
      color: Colors.orange,
    ),
    Transaction(
      title: 'Tira',
      date: 'Feb 09, 2026',
      amount: 3550.00,
      isExpense: false,
      icon: Icons.trending_up,
      color: Colors.green,
    ),
  ];

  final List<FinancialCategory> categories = [
    FinancialCategory(
      name: 'Savings',
      amount: 12500.00,
      icon: Icons.savings,
      color: Colors.blue,
    ),
    FinancialCategory(
      name: 'Expenses',
      amount: 2870.50,
      icon: Icons.shopping_bag,
      color: Colors.red,
    ),
    FinancialCategory(
      name: 'Investments',
      amount: 8500.00,
      icon: Icons.show_chart,
      color: Colors.green,
    ),
    FinancialCategory(
      name: 'Bills',
      amount: 450.00,
      icon: Icons.receipt_long,
      color: Colors.orange,
    ),
  ];

  double get totalBalance {
    double balance = 0;
    for (var transaction in transactions) {
      if (transaction.isExpense) {
        balance -= transaction.amount;
      } else {
        balance += transaction.amount;
      }
    }
    return balance + 15000;
  }

  double get totalIncome {
    return transactions
        .where((t) => !t.isExpense)
        .fold(0, (sum, t) => sum + t.amount);
  }

  double get totalExpense {
    return transactions
        .where((t) => t.isExpense)
        .fold(0, (sum, t) => sum + t.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Financial Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBalanceCard(),
            const SizedBox(height: 20),
            _buildIncomeExpenseOverview(),
            const SizedBox(height: 20),
            _buildCategoriesSection(),
            const SizedBox(height: 20),
            _buildTransactionHistory(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.lightBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Balance',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            '₹${totalBalance.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.visibility_outlined, color: Colors.white70),
              const SizedBox(width: 5),
              const Text(
                'Account Summary',
                style: TextStyle(color: Colors.white70),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Active',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeExpenseOverview() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildOverviewCard(
              'Income',
              totalIncome,
              Icons.arrow_downward,
              Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildOverviewCard(
              'Expenses',
              totalExpense,
              Icons.arrow_upward,
              Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(
    String title,
    double amount,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const Spacer(),
              Icon(Icons.more_vert, color: Colors.grey[400]),
            ],
          ),
          const SizedBox(height: 15),
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          const SizedBox(height: 5),
          Text(
            '₹${amount.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Financial Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(onPressed: () {}, child: const Text('View All')),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return _buildCategoryCard(categories[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(FinancialCategory category) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: category.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(category.icon, color: category.color),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.name,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                '₹${category.amount.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Transaction History',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(onPressed: () {}, child: const Text('See All')),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            return _buildTransactionItem(transactions[index]);
          },
        ),
      ],
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: transaction.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(transaction.icon, color: transaction.color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.date,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Text(
            '${transaction.isExpense ? '-' : '+'}₹${transaction.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: transaction.isExpense ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
