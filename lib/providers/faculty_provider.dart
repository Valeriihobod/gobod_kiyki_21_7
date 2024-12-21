import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/faculty.dart';
import 'package:flutter/material.dart';

const List<Faculty> predefinedFaculties = [
  Faculty(
    id: 'finance',
    title: 'Finance',
    symbol: Icons.account_balance_wallet, 
    tone: Colors.amber,
  ),
  Faculty(
    id: 'law',
    title: 'Law',
    symbol: Icons.scale,
    tone: Colors.deepPurple, 
  ),
  Faculty(
    id: 'tech',
    title: 'Technology',
    symbol: Icons.memory,
    tone: Colors.indigo, 
  ),
  Faculty(
    id: 'health',
    title: 'Healthcare',
    symbol: Icons.healing, 
    tone: Colors.orange,
  ),

];

final facultiesProvider = Provider<List<Faculty>>((ref) => predefinedFaculties);
