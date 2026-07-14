import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../services/api_service.dart';
import '../product/product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<Product> _allProducts = [];
  List<Product> _suggestions = [];
  List<Product> _results = [];

  bool _isLoading = true;
  bool _hasSearched = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _searchController.addListener(_onQueryChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onQueryChanged);
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await ApiService.getProducts();
      setState(() {
        _allProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Không thể tải danh sách sản phẩm";
        _isLoading = false;
      });
    }
  }

  List<Product> _filter(String query) {
    return _allProducts
        .where((p) => p.name.toLowerCase().contains(query))
        .toList();
  }

  // Gõ tới đâu, gợi ý sản phẩm tới đó
  void _onQueryChanged() {
    final query = _searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      setState(() {
        _suggestions = [];
        _results = [];
        _hasSearched = false;
      });
      return;
    }

    final matches = _filter(query);

    setState(() {
      _suggestions = matches.take(6).toList();
      // Nếu người dùng đang sửa lại từ khoá sau khi đã tìm kiếm,
      // cập nhật luôn kết quả bên dưới cho khớp
      if (_hasSearched) {
        _results = matches;
      }
    });
  }

  // Bấm nút tìm kiếm / Enter -> hiển thị các sản phẩm tương tự từ khoá
  void _performSearch([String? value]) {
    final query = (value ?? _searchController.text).trim().toLowerCase();
    if (query.isEmpty) return;

    final matches = _filter(query);

    setState(() {
      _results = matches;
      _suggestions = [];
      _hasSearched = true;
    });

    _focusNode.unfocus();
  }

  void _selectSuggestion(Product product) {
    _searchController.text = product.name;
    _searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: _searchController.text.length),
    );
    _performSearch(product.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Container(
          height: 42,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: _searchController,
            focusNode: _focusNode,
            autofocus: true,
            textInputAction: TextInputAction.search,
            onSubmitted: _performSearch,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Tìm sản phẩm",
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isEmpty
                  ? null
                  : IconButton(
                icon: const Icon(Icons.clear, size: 20),
                onPressed: () => _searchController.clear(),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => _performSearch(),
            child: const Text("Tìm"),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!));
    }

    final query = _searchController.text.trim();

    if (query.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            "Nhập tên sản phẩm để tìm kiếm",
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // Đã bấm tìm kiếm -> hiển thị các sản phẩm tương tự dạng lưới
    if (_hasSearched) {
      if (_results.isEmpty) {
        return Center(
          child: Text('Không tìm thấy sản phẩm nào cho "$query"'),
        );
      }
      return _buildResultsGrid();
    }

    // Đang gõ -> hiển thị danh sách gợi ý
    if (_suggestions.isEmpty) {
      return const Center(
        child: Text(
          "Không có gợi ý phù hợp",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return _buildSuggestionsList();
  }

  Widget _buildSuggestionsList() {
    return ListView.separated(
      itemCount: _suggestions.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final product = _suggestions[index];
        return ListTile(
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFEFEFEF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: product.image.isNotEmpty
                ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image, color: Colors.grey),
              ),
            )
                : const Icon(Icons.image, color: Colors.grey),
          ),
          title: Text(product.name),
          subtitle: Text("${product.price} đ"),
          trailing: const Icon(Icons.north_west, size: 16, color: Colors.grey),
          onTap: () => _selectSuggestion(product),
        );
      },
    );
  }

  Widget _buildResultsGrid() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: GridView.builder(
        itemCount: _results.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          final product = _results[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(
                    product: product,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Container(
                        width: double.infinity,
                        color: const Color(0xFFEFEFEF),
                        child: product.image.isNotEmpty
                            ? Image.network(
                          product.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                          const Center(
                            child: Icon(Icons.image,
                                size: 40, color: Colors.grey),
                          ),
                        )
                            : const Center(
                          child: Icon(Icons.image,
                              size: 40, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${product.price} đ",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}