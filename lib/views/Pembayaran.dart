import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:ticketing_app/views/Struk.dart';
import 'package:ticketing_app/services/firebase.dart';

// import 'package:ticketing_app/services/firebase.dart';

class PembayaranPage extends StatefulWidget {
  final String tiketId;
  final String name;
  final String jenisTiket;
  final int harga;
  final Timestamp tanggal;

  const PembayaranPage(
      {super.key,
      required this.tiketId,
      required this.name,
      required this.jenisTiket,
      required this.tanggal,
      required this.harga});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  final fireStoreService = FireStoreService(); // ✅ Tambahkan ini kalau belum
  void openCashAlertBox(String tiketId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pembayaran Tunai",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D4ED8)),
                      ),
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.close))
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFF3F4F6),
                      image: DecorationImage(
                        image: AssetImage('assets/images/image6.png'),
                        fit: BoxFit.none,
                        scale: 1.9,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Text(
                        'Pembayaran Tunai',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        child: Text(
                          'Jika pembayaran telah diterima, klik button konfirmasi pembayaran untuk menyelesaikan transaksi',
                          style: GoogleFonts.poppins(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                        width: 210,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          // Tambahkan pembelian
                          await fireStoreService.addPembelian({
                            'tiketId': tiketId,
                            'name': widget.name,
                            'jenis_tiket': widget.jenisTiket,
                            'Harga': widget.harga,
                            'Metode_Pembayaran': 'Cash',
                            'created_at': FieldValue.serverTimestamp()
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => StrukPage(tiketId: tiketId, name: widget.name, jenisTiket: widget.jenisTiket, harga: widget.harga, tanggal: widget.tanggal,)));
                        },
                        child: Text(
                          'Konfirmasi Pembayaran',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1D4ED8)),
                      )
                    ],
                  )
                ],
              ),
            ));
  }

  void openKreditAlertBox(String tiketId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pembayaran Kartu Kredit",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D4ED8)),
                      ),
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.close))
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFF3F4F6),
                      image: DecorationImage(
                        image: AssetImage('assets/images/image7.png'),
                        fit: BoxFit.none,
                        scale: 1.9,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Container(
                        height: 40,
                        width: 222,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Color(0xFF1D4ED8), width: 1),
                        ),
                       child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '8810 7766 1234 9876',
                                  style: GoogleFonts.poppins(fontSize: 12),
                                  textAlign: TextAlign
                                      .center, // teks rata tengah dalam Expanded
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.copy),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: '8810 7766 1234 9876'));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Teks berhasil disalin!')),
                                  );
                                },
                              ),
                            ],
                          ),
                      ),
                       SizedBox(height: 20),
                      Text(
                        'Transfer Pembayaran',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        child: Text(
                          'Pastikan nominal dan tujuan pembayaran sudah benar sebelum melanjutkan.',
                          style: GoogleFonts.poppins(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                        width: 210,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          // Tambahkan pembelian
                          await fireStoreService.addPembelian({
                            'tiketId': tiketId,
                            'name': widget.name,
                            'jenis_tiket': widget.jenisTiket,
                            'Harga': widget.harga,
                            'Metode_Pembayaran': 'Kartu Kredit',
                            'created_at': FieldValue.serverTimestamp()
                          });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StrukPage(
                                        tiketId: tiketId,
                                        name: widget.name,
                                        jenisTiket: widget.jenisTiket,
                                        harga: widget.harga,
                                        tanggal: widget.tanggal,
                                      )));
                        },
                        child: Text(
                          'Konfirmasi Pembayaran',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1D4ED8)),
                      )
                    ],
                  )
                ],
              ),
            ));
  }

  void openQrAlertBox(String tiketId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pembayaran QRIS",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D4ED8)),
                      ),
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.close))
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFF3F4F6),
                      image: DecorationImage(
                        image: AssetImage('assets/images/image8.png'),
                        fit: BoxFit.none,
                        scale: 1.9,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Text(
                        'Scan QR untuk Membayar',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        child: Text(
                          'Gunakan aplikasi e-wallet atau mobile banking untuk scan QR di atas dan selesaikan pembayaran',
                          style: GoogleFonts.poppins(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                        width: 210,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          // Tambahkan pembelian
                          await fireStoreService.addPembelian({
                            'tiketId': tiketId,
                            'name': widget.name,
                            'jenis_tiket': widget.jenisTiket,
                            'Harga': widget.harga,
                            'Metode_Pembayaran': 'QRIS',
                            'created_at': FieldValue.serverTimestamp()
                          });
                          
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StrukPage(
                                        tiketId: tiketId,
                                        name: widget.name,
                                        jenisTiket: widget.jenisTiket,
                                        harga: widget.harga,
                                        tanggal: widget.tanggal,
                                      )));
                        },
                        child: Text(
                          'Konfirmasi Pembayaran',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1D4ED8)),
                      )
                    ],
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Pembayaran",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              color: Colors.white,
              elevation: 6,
              shadowColor: Colors.grey,
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color(0xFFF3F4F6),
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/image2.png',
                                ),
                                fit: BoxFit.none,
                                scale: 2)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Tagihan',
                            style: GoogleFonts.poppins(fontSize: 12),
                          ),
                          Text(
                            'Rp ' + widget.harga.toString(),
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nama pesanan',
                              style: GoogleFonts.poppins(fontSize: 12)),
                          Text('${widget.name} - ${widget.jenisTiket}',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Tanggal',
                              style: GoogleFonts.poppins(fontSize: 12)),
                          Text(
                              DateFormat('d MMMM yyyy', 'id_ID')
                                  .format(widget.tanggal.toDate()),
                              style: GoogleFonts.poppins(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pilih Metode Pembayaran',
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                // Tunai
                Card(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      openCashAlertBox(widget.tiketId);
                    },
                    child: ListTile(
                      title: Row(
                        children: [
                          Image.asset('assets/images/image3.png',
                              height: 30, width: 30),
                          SizedBox(width: 10),
                          Text('Tunai',
                              style: GoogleFonts.poppins(fontSize: 16)),
                        ],
                      ),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // Kartu Kredit
                Card(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      openKreditAlertBox(widget.tiketId);
                    },
                    child: ListTile(
                      title: Row(
                        children: [
                          Image.asset('assets/images/image4.png',
                              height: 30, width: 30),
                          SizedBox(width: 10),
                          Text('Kartu Kredit',
                              style: GoogleFonts.poppins(fontSize: 16)),
                        ],
                      ),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // Qris/QR Pay
                Card(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      openQrAlertBox(widget.tiketId);
                    },
                    child: ListTile(
                      title: Row(
                        children: [
                          Image.asset('assets/images/image5.png',
                              height: 30, width: 30),
                          SizedBox(width: 10),
                          Text('Qris/QR Pay',
                              style: GoogleFonts.poppins(fontSize: 16)),
                        ],
                      ),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                ),
              ],
            ),
           SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Punya Pertanyaan ?',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 10),
          Card(
            color: Colors.white,
            child: ListTile(
              title: Row(
                children: [
                  Image.asset('assets/images/image10.png', height: 30, width: 30),
                  SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hubungi Admin untuk bantuan',
                        style: GoogleFonts.poppins(fontSize: 12)),
                    Text('pembayaran',
                        style: GoogleFonts.poppins(
                           fontSize: 12)),
                  ],
                )
                ],
              ),
            ),
          )
          ],
        ),
      ),
    );
  }
}
