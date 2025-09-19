import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InlineCalendar extends StatefulWidget {
  final String label;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? Function(DateTime?)? validator;

  const InlineCalendar({
    super.key,
    required this.label,
    this.selectedDate,
    required this.onDateSelected,
    this.firstDate,
    this.lastDate,
    this.validator,
  });

  @override
  State<InlineCalendar> createState() => _InlineCalendarState();
}

class _InlineCalendarState extends State<InlineCalendar> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.selectedDate != null
                      ? DateFormat('dd/MM/yyyy').format(widget.selectedDate!)
                      : 'Select ${widget.label}',
                  style: TextStyle(
                    color: widget.selectedDate != null
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                    fontSize: 16,
                  ),
                ),
                Icon(
                  _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.white.withOpacity(0.7),
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _isExpanded ? 320 : 0,
          child: _isExpanded
              ? Container(
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: const Color(0xFF6C63FF),
                        onPrimary: Colors.white,
                        surface: Colors.transparent,
                        onSurface: Colors.white,
                      ),
                    ),
                    child: CalendarDatePicker(
                      initialDate: widget.selectedDate ?? DateTime.now(),
                      firstDate: widget.firstDate ?? DateTime(1900),
                      lastDate: widget.lastDate ?? DateTime(2100),
                      onDateChanged: (date) {
                        widget.onDateSelected(date);
                        setState(() {
                          _isExpanded = false;
                        });
                      },
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
        if (widget.validator != null && widget.selectedDate != null)
          Builder(
            builder: (context) {
              final error = widget.validator!(widget.selectedDate);
              if (error != null) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    error,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
      ],
    );
  }
}