<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
//
//Class name: Penjualan controller
//version : 1.0
//Author : Iswan Putera

class Penjualan extends CI_Controller{
	function __construct(){
		parent::__construct();
		$this->load->model("Admin_model");
		$this->load->model("inv_model");
		$this->load->model("kasir_model");
		$this->load->library('zetro_auth');
		$this->load->library('zetro_slip');
		$this->load->model("report_model");
		$this->load->helper("print_report");
		$this->load->helper("print_report2");
	}
	
	function Header(){ 
	// load header
		$this->load->view('admin/header');	
	}
	
	function Footer(){
	//load footer
		$this->load->view('admin/footer');	
	}
	function list_data($data){
	//membentuk data array untuk dikirim saat load view
		$this->data=$data;
	}
	function View($view){
		$this->Header();
		$this->zetro_auth->view($view);
		$this->load->view($view,$this->data);	
		$this->Footer();
	}
	//tampilan awal ketika menu input pembelian di klik
	function index(){
		$data=array();
		$this->zetro_auth->menu_id(array('penjualan__index'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('penjualan/material_jual');
	}
	// pejualan dengan resep untuk apotik
	function resep_std(){
		$data=array();
		$this->zetro_auth->menu_id(array('penjualan__resep_std'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('penjualan/material_jual_resep');
	}
	//generate nomor transaksi otomatis
	function nomor_transaksi(){
		$tipe=$_POST['tipe'];
		$nomor=$this->Admin_model->penomoran($tipe);
		echo $nomor;	
	}
	//generate nomor faktur penjualan
	function nomor_faktur(){
		$faktur=date('Ymd')."-".rand(1000,9999);
		echo $faktur;	
	}
	
	function hapus_resep_kosong(){
	//hapus data resep yang stock nya kosong dan sudah expire 
	$this->inv_model->hapus_resep_kosong();
		
	}
	
	function get_satuan(){
		$data=array();
		$nm_barang=$_POST['nm_barang'];
		$rsp=$_POST['rsp'];
		$expired=$this->Admin_model->show_single_field('inv_material_stok','expired',"where nm_barang='$nm_barang' order by min(expired)");
		$harga=$this->Admin_model->show_single_field('inv_material_stok','harga_beli',"where nm_barang='$nm_barang' and expired='$expired'");
		$margin=1;//$this->Admin_model->show_single_field('inv_material','margin_jual',"where nm_barang='$nm_barang'");
		$uom=$this->Admin_model->show_single_field('inv_material','nm_satuan',"where nm_barang='$nm_barang'");
		($rsp=='n')?
			$satuan=$this->Admin_model->show_single_field('inv_material','nm_satuan',"where nm_barang='$nm_barang'"):
			$satuan=$this->Admin_model->show_single_field('inv_konversi','sat_beli',"where nm_barang='$nm_barang' order by min(isi_konversi)");
		($satuan=='')?
			$data['satuan']=$this->Admin_model->show_single_field('inv_material','nm_satuan',"where nm_barang='$nm_barang'"):
			$data['satuan']=$satuan;
			$isikonv=$this->Admin_model->show_single_field('inv_konversi','isi_konversi',"where nm_barang='$nm_barang' and sat_beli='$satuan'");
		($uom!=$satuan)?$harga=($harga*$isikonv):$harga=$harga;
		$data['expired']=tglfromSql($expired);
		$data['stock']=$this->Admin_model->show_single_field('inv_material_stok','stock',"where nm_barang='$nm_barang' and expired='$expired'");
		$data['harga_jual']=(($harga*$margin/100)+$harga);
		echo json_encode($data);
	}
	//simpan data header transaksi
	function set_header_trans(){
		$data=array();$datax=array();
		$cek_nourut	=rdb('inv_penjualan','NoUrut','NoUrut',"where NoUrut='".$_POST['no_trans']."'");
		$data['NoUrut']		=$_POST['no_trans'];
		$data['Tanggal']	=tgltoSql($_POST['tanggal']);
		$data['Nomor']		=$_POST['faktur'];
		$data['ID_Anggota']	=empty($_POST['member'])?'0':$_POST['member'];
		$data['ID_Jenis']	=$_POST['cbayar'];
		$data['Bulan']		=substr($_POST['tanggal'],3,2);
		$data['Tahun']		=substr($_POST['tanggal'],6,4);
		$data['Total']		=empty($_POST['total'])?'0':$_POST['total'];
		$data['cicilan']	=empty($_POST['cicilan'])?'0':$_POST['cicilan'];
		$data['ID_Lokasi']		=empty($_POST['lokasi'])?'1':$_POST['lokasi'];
		if($cek_nourut==''){
		$this->Admin_model->replace_data('inv_penjualan',$data);
		}
		//update nomor transaksi	
		$datax['nomor']		=$_POST['no_trans'];
		$datax['jenis_transaksi']='GI';
		$this->Admin_model->replace_data('nomor_transaksi',$datax);
	}
	function update_header_trans(){
		$data=array();
		$no_trans	=$_POST['no_trans'];
		$ID_Jenis	=$_POST['id_jenis'];
		$TotalHg	=empty($_POST['total'])?'0':$_POST['total'];
		$Tanggal	=$_POST['tanggal'];
		$id_anggota	=empty($_POST['id_anggota'])?'0':$_POST['id_anggota'];
		$cicilan	=empty($_POST['cicilan'])?'0'	:$_POST['cicilan'];
		$nogiro		=empty($_POST['nogiro'])?'0'	:strtoupper($_POST['nogiro']);
		$n_bank		=empty($_POST['n_bank'])?''		:strtoupper(addslashes($_POST['n_bank']));
		$tgl_giro	=empty($_POST['tgl_giro'])?'0000-00-00'	:tgltoSql($_POST['tgl_giro']);
		$lokasi		=empty($_POST['lokasi'])?'1':$_POST['lokasi'];
		$this->Admin_model->upd_data('inv_penjualan',"set ID_Jenis='".$ID_Jenis."', ID_Anggota='".$id_anggota."', Total='".$TotalHg."', Cicilan='".$cicilan."',ID_Post='".$nogiro."', Deskripsi='".$n_bank."', Tgl_Cicilan='".$tgl_giro."'",
									 "where NoUrut='".$no_trans."' and	Tanggal='".tgltoSql($Tanggal)."'");
		$this->no_transaksi($no_trans);
		$this->tanggal($Tanggal);
		$this->JenisBayar($ID_Jenis);
		if($TotalHg!='0'){
			if(($ID_Jenis!='4' || $ID_Jenis!='5') && $id_anggota!=''){
				$this->process_to_jurnal($id_anggota,$TotalHg,'',$lokasi);
			}else if($this->id_jenis=='5'){
				$ket='Pembayaran Retur Barang tanggal $Tanggal';	
				$this->process_to_jurnal($id_anggota,$TotalHg,$ket,$lokasi);
			}
		}
	}

	function set_detail_trans(){
		$data=array();
		$cekstatus=array();$countdata=0;
		//get ID from header trans
		$data['Keterangan']	=$_POST['no_trans'];
		$data['ID_Jual']	=rdb('inv_penjualan','ID','ID',"where NoUrut='".$_POST['no_trans']."' and Tanggal='".tgltoSql($_POST['tanggal'])."'");
		$data['ID_Barang']	=rdb('inv_barang','ID','ID',"where Nama_Barang='".$_POST['nm_barang']."'");
		$data['ID_Jenis']	=$_POST['cbayar'];
		$data['Jumlah']		=$_POST['jml_trans'];
		$data['Harga']		=$_POST['harga_jual'];
		$data['Tanggal']	=tgltoSql($_POST['tanggal']);
		$data['Bulan']		=$_POST['no_id'];
		$data['ID_Post']	=$_POST['id_post'];
		$data['batch']		=empty($_POST['batch'])?'0':$_POST['batch'];
		$data['ID_Satuan']	=rdb('inv_barang','ID_Satuan','ID_Satuan',"where Nama_Barang='".$_POST['nm_barang']."'");
		$countdata=rdb('inv_penjualan_detail','ID','ID',"where Bulan='".$_POST['no_id']."' and Keterangan='".$_POST['no_trans']."' and Tanggal='".tgltoSql($_POST['tanggal'])."'");
		//$this->inv_model->total_record('inv_penjualan_detail',"where ID_Jual='$id_jual'",'id_jual');
		if($countdata==''){
				$this->Admin_model->replace_data('inv_penjualan_detail',$data);
		}else{
			$data['ID']=$countdata;
			$this->Admin_model->simpan_update('inv_penjualan_detail',$data,'ID');
		}
	}
	//simpan pembayaran	
	//simpan pembayaran	
	function simpan_bayar(){
		$data=array();
		$data['no_transaksi']	=$_POST['no_transaksi'];
		$data['total_belanja']	=$_POST['total_belanja'];
		$data['ppn']			=$_POST['ppn'];	
		$data['total_bayar']	=$_POST['total_bayar'];	
		$data['jml_dibayar']	=$_POST['dibayar'];	
		$data['kembalian']		=$_POST['kembalian'];
		$data['ID_Jenis']		=$_POST['cbayar'];
		$data['created_by']	=$this->session->userdata('userid');
		$this->Admin_model->replace_data('inv_pembayaran',$data);
		//$this->Admin_model->hps_data('inv_material',"where nm_barang='".$_POST[
		echo $_POST['no_transaksi'];
	}
	function update_stock_return(){
		$ntran	=$_POST['no_trans'];
		$tgl	=tglToSql($_POST['tanggal']);
		$lokasi =empty($_POST['lokasi'])?'1':$_POST['lokasi'];
		$this->return_stock($ntran,$tgl,$lokasi);
		echo '';
	}
	//update data stok material setelah di lakukan transaksi
	//transaksi penjualan
	function update_material_stock($ntran='',$tgl=''){
		$data=array();$first_stock=0;$end_stock=0;$datax=array();$hgb=0;$bt='';
		$ntran	=$_POST['no_trans'];
		$tgl	=tglToSql($_POST['tanggal']);
		$lokasi	=empty($_POST['lokasi'])?'1':$_POST['lokasi'];
		$data=$this->Admin_model->show_list('inv_penjualan_detail',"where ID_Jual='".rdb('inv_penjualan','ID','ID',"where NoUrut='".$ntran."' and Tanggal='". $tgl."'")."'");
		$id_br=rdb('inv_penjualan_detail','ID_Barang','ID_Barang',"where ID_Jual='".rdb('inv_penjualan','ID','ID',"where NoUrut='".$ntran."' and Tanggal='". $tgl."'")."'");
		//print_r($data);
		foreach($data as $r){
		$bath=$this->inv_model->get_detail_stocked($r->ID_Barang,'desc');
			foreach($bath as $w){
				$bt=$w->batch;
			}
			$jumlah=empty($_POST['jumlah'])?$r->Jumlah:$_POST['jumlah'];
			$hgb=rdb('inv_material_stok','harga_beli','harga_beli',"where id_barang='".$r->ID_Barang."' and batch='".$bt."' and id_lokasi='".$lokasi."'");
			$first_stock=rdb('inv_material_stok','stock','stock',"where id_barang='".$r->ID_Barang."' and batch='".$bt."' and id_lokasi='".$lokasi."'");
			$end_stock=($first_stock-abs($jumlah));
			$end_stock=($end_stock<0)? 0:$end_stock;
			$datax['id_lokasi'] =$lokasi;
			$datax['id_barang']	=$r->ID_Barang;
			$datax['nm_barang']	=rdb('inv_barang','Nama_Barang','Nama_Barang',"where ID='".$r->ID_Barang."'");
			$datax['batch']		=$bt;
			$datax['stock']		=$end_stock;
			$datax['harga_beli']=empty($hgb)?'0':$hgb;
			$datax['nm_satuan'] =rdb('inv_barang','ID_Satuan','ID_Satuan',"where ID='".$r->ID_Barang."'");
			$this->Admin_model->replace_data('inv_material_stok',$datax);
		}
		 echo ($first_stock-$r->Jumlah);
	}
	function update_stock(){
	//update stock new version	
	}
	
	function return_stock($ntran,$tgl,$lokasi=''){
		$data=array();$first_stock=0;$end_stock=0;$datax=array();$hgb=0;
		$data=$this->Admin_model->show_list('inv_penjualan_detail',"where ID_Jual='".rdb('inv_penjualan','ID','ID',"where NoUrut='".$ntran."' and Tanggal='". $tgl."'")."'");
		//print_r($data);
		foreach($data as $r){
			$hgb=rdb('inv_material_stok','harga_beli','harga_beli',"where id_barang='".$r->ID_Barang."' and batch='".$r->Batch."' and id_lokasi='".$lokasi."'");
			$first_stock=rdb('inv_material_stok','stock','stock',"where id_barang='".$r->ID_Barang."' and batch='".$r->Batch."' and id_lokasi='".$lokasi."'");
			$end_stock=($first_stock+(abs($r->Jumlah)));
			$datax['id_lokasi'] =$lokasi;
			$datax['id_barang']	=$r->ID_Barang;
			$datax['nm_barang']	=rdb('inv_barang','Nama_Barang','Nama_Barang',"where ID='".$r->ID_Barang."'");
			$datax['batch']		=$r->Batch;
			$datax['stock']		=$end_stock;
			$datax['harga_beli']=empty($hgb)?'0':$hgb;
			$datax['nm_satuan'] =rdb('inv_barang','ID_Satuan','ID_Satuan',"where ID='".$r->ID_Barang."'");
			$this->Admin_model->replace_data('inv_material_stok',$datax);
		}
	}
	function transaski_kas(){
		//pembayaran return material diambil dari uang kas toko
		$data=array();
		$data['id_trans']	=$_POST['no_trans'];
		$data['id_kas']		='KAS TOKO';	
	}
	function batal_transaksi(){
		//$this->return_stock($_POST['no_trans'],tgltoSql($_POST['tanggal']));
		$this->Admin_model->hps_data('inv_penjualan',"where NoUrut='".$_POST['no_trans']."' and Tanggal='".tgltoSql($_POST['tanggal'])."'");	
	}
	function get_total_trans(){
		$no_trans=@$_POST['no_trans'];
		$table=$_POST['table'];
		$where="where no_transaksi='$no_trans' and jenis_transaksi='GI'";
		
		$row_count=$this->inv_model->total_record($table,$where);
		echo $row_count;
	}
	//adjust stock barang di table inv_material
	function update_adjust(){
		$nm_barang=$_POST['nm_barang'];
		$stock=$_POST['stock'];
		$this->Admin_model->upd_data('inv_material','stock',"where nm_barang='".$nm_barang."'");
	}

	function _filename(){
		//configurasi data untuk generate form & list
		$this->zetro_buildlist->config_file('asset/bin/zetro_beli.frm');
		$this->zetro_buildlist->aksi();
		$this->zetro_buildlist->icon();
	}
	
	function _generate_list($data,$section,$list_key='nm_barang',$icon='deleted',$aksi=true,$sub_total=false){
			//prepare table
			$this->_filename();
			$this->zetro_buildlist->aksi($aksi); 
			$this->zetro_buildlist->section($section);
			$this->zetro_buildlist->icon($icon);
			$this->zetro_buildlist->query($data);
			//bulid subtotal
			$this->zetro_buildlist->sub_total($sub_total);
			$this->zetro_buildlist->sub_total_kolom('4,5');
			$this->zetro_buildlist->sub_total_field('stock,blokstok');
			//show data in table
			$this->zetro_buildlist->list_data($section);
			$this->zetro_buildlist->BuildListData($list_key);
	}
	
	//proses print slip penjualan
	//create data text for print to dotmatrix
	function no_transaksi($no_trans){
		$this->no_trans=$no_trans;
	}
	function tanggal($tgl){
		$this->tgl=$tgl;
	}
	function redir(){
		redirect('penjualan/index');
	}
	function print_slip(){
		$this->zetro_slip->path=$this->session->userdata('userid');
		$this->zetro_slip->modele('wb');
		$this->zetro_slip->newline();
		$this->no_transaksi($_POST['no_transaksi']);
		$this->tanggal(tgltoSql($_POST['tanggal']));
		$this->zetro_slip->content($this->struk_header());
		$this->zetro_slip->create_file();
		echo $this->session->userdata('userid');
	}
	function struk_header(){
		$data=array();
		$slip="S L I P  P E N J U A L A N";
		$no_trans=$this->no_trans;
		$nfile	='asset/bin/zetro_config.dll';
		$lokasi	=empty($_POST['lokasi'])?'1':$_POST['lokasi'];
		$gudang=rdb('user_lokasi','lokasi','lokasi',"where id='".$lokasi."'");
		$coy	=$this->zetro_manager->rContent($gudang,'Name',$nfile);	
		$address=$this->zetro_manager->rContent($gudang,'Address',$nfile);
		$city	=$this->zetro_manager->rContent($gudang,'Kota',$nfile);
		$phone	=$this->zetro_manager->rContent($gudang,'Telp',$nfile);
		$fax	=$this->zetro_manager->rContent($gudang,'Fax',$nfile);
		$tgl	=rdb('inv_penjualan','Tanggal','Tanggal',"where NoUrut='".$no_trans."' and Tanggal='".$this->tgl."'");
		$Jenis	=rdb('inv_penjualan','ID_Jenis','ID_Jenis',"where NoUrut='".$no_trans."' and Tanggal='".$this->tgl."'");
		$nJenis	=rdb('inv_penjualan_jenis','Jenis_Jual','Jenis_Jual',"where ID='".$Jenis."'");
		$no_faktur=rdb('inv_penjualan','Nomor','Nomor',"where NoUrut='".$no_trans."' and Tanggal='".$this->tgl."'");
		$nama=rdb('mst_anggota','Nama','Nama',"where ID='".rdb('inv_penjualan','ID_Anggota','ID_Anggota',"where NoUrut='".$this->no_trans."' and Tanggal='".$this->tgl."'")."'");
		$urut=rdb('mst_anggota','No_Agt','No_Agt',"where ID='".rdb('inv_penjualan','ID_Anggota','ID_Anggota',"where NoUrut='".$this->no_trans."' and Tanggal='".$this->tgl."'")."'");
		$alm =rdb('mst_anggota','Alamat',"Alamat","where ID='".
			  rdb('inv_penjualan','ID_Anggota','ID_Anggota',"where NoUrut='".$this->no_trans."' and Tanggal='".$this->tgl."'")."'");
		$kasir=$this->session->userdata('username');
		$isine	=array(
					$coy.newline(),
					strtoupper($address).sepasi((79-strlen($address)-strlen('FAKTUR PEMBELIAN'))).'FAKTUR PEMBELIAN'.newline(),
					'Tanggal :'.date('d-m-Y H:i').sepasi((79-strlen('Tanggal :'.date('d-m-Y H:i'))-strlen('Kepada Yth,'))).'Kepada Yth,'.newline(),
					'Kasir : '.$kasir.sepasi((79-strlen($nama)-strlen('Kasir : '.$kasir))).$nama.newline(),
					'Nota  : '.$no_faktur.sepasi((79-strlen($alm)-strlen('Nota  : '.$no_faktur))).$alm.newline(),
					str_repeat('-',79).newline(),
					'| No.|'.sepasi(((32-strlen('Nama Barang'))/2)).'Nama Barang'.sepasi(((32-strlen('Nama Barang'))/2)).
					'|'.sepasi(((10-strlen('Banyaknya'))/2)).'Banyaknya'.sepasi((((10-strlen('Banyaknya'))/2)-1)).'|'.
					sepasi(((14-strlen('Harga Satuan'))/2)).'Harga Satuan'.sepasi((((14-strlen('Harga Satuan'))/2)-1)).'|'.
					sepasi(((18-strlen('Total Harga'))/2)).'Total Harga'.sepasi((((17-strlen('Total Harga'))/2)-1)).'|'.newline(),
					str_repeat('-',79).newline(),
					$this->isi_slip(),
					$this->struk_data_footer()
					);
		return $isine;			
	}
	function isi_slip(){
		$data=array();$content="";$n=0;
		$this->inv_model->tabel('inv_penjualan_rekap');
		$data=$this->kasir_model->get_trans_jual($this->no_trans,$this->tgl);
		 foreach($data as $row){
			 $n++;
			 $satuan=rdb('inv_barang_satuan','Satuan','Satuan',"where ID='".
			 		 rdb('inv_barang','ID_Satuan','ID_Satuan',"where ID='".$row->ID_Barang."'")."'");
			$nama_barang=rdb('inv_barang','Nama_Barang','Nama_Barang',"where ID='".$row->ID_Barang."'");
			$kategori=rdb('inv_barang_kategori','Kategori','Kategori',"where ID='".
					 rdb('inv_barang','ID_Kategori','ID_Kategori',"where ID='".$row->ID_Barang."'")."'");
			$content .=sepasi(((6-strlen($n))/2)).$n.sepasi((4-strlen($n))).substr($kategori,0,10).sepasi().substr(ucwords(($nama_barang)),0,31).
					 sepasi(((30-strlen($kategori))-strlen($nama_barang))).
					 sepasi((10-strlen($row->Jumlah)-strlen($satuan)-2)).round($row->Jumlah,0).sepasi(1).$satuan.
					 sepasi((14-strlen(number_format($row->Harga)))).number_format($row->Harga).
					 sepasi((16-strlen(number_format(($row->Jumlah *$row->Harga),2)))).number_format(($row->Jumlah *$row->Harga),2).newline();
		 }
		 if($n<=10){
			 $content .=newline((10-$n));
		 }
		 return $content;
		 
	}
	function struk_data_footer(){
		$data	=array();$bawah="";
		$nfile	='asset/bin/zetro_config.dll';
		$lokasi	=empty($_POST['lokasi'])?'1':$_POST['lokasi'];
		$gudang	=rdb('user_lokasi','lokasi','lokasi',"where id='".$lokasi."'");
		$phone	=$this->zetro_manager->rContent($gudang,'Telp',$nfile);
		$tgl	=rdb('inv_penjualan','Tanggal','Tanggal',"where NoUrut='".$this->no_trans."' and Tanggal='".$this->tgl."'");
		$this->inv_model->tabel('inv_pembayaran');
		$data=$this->inv_model->show_list_1where('no_transaksi',$this->no_trans);
			foreach($data->result() as $row){
				$bawah=str_repeat('-',79).newline().
				'*** Terima Kasih ***'.sepasi((61-strlen('*** Terima Kasih ***')-strlen('Jumlah RP. :'))).'Jumlah Rp. :'.sepasi((15-strlen(number_format($row->total_belanja,2)))).number_format($row->total_belanja,2).newline().
				'INFORMASI '.$phone.sepasi((61-strlen('INFORMASI '.$phone)-strlen('Tunai (DP) :'))).'Tunai (DP) :'./*sepasi((15-strlen(number_format($row->jml_dibayar,2)))).number_format($row->jml_dibayar,2).*/newline().
				'Doc. No.'.$this->no_trans.' '.tglfromSql($tgl).sepasi((61-strlen('Doc. No.'.$this->no_trans.' '.tglfromSql($tgl))-strlen('Kembali Rp. :'))).'Kembali Rp. :'./*sepasi((15-strlen(number_format($row->kembalian,2)))).number_format($row->kembalian,2).*/newline().
				str_repeat('-',79).newline().
				'Penerima                Gudang                Hormat Kami'.newline(1);
				
			}
		return $bawah;
	}
	function struk_data_footer_kredit(){
		$data=array();$bawah="";
		$nama=rdb('mst_anggota','Nama','Nama',"where ID='".rdb('inv_penjualan','ID_Anggota','ID_Anggota',"where NoUrut='".$this->no_trans."' and Tanggal='".$this->tgl."'")."'");
		$urut=rdb('mst_anggota','No_Agt','No_Agt',"where ID='".rdb('inv_penjualan','ID_Anggota','ID_Anggota',"where NoUrut='".$this->no_trans."' and Tanggal='".$this->tgl."'")."'");
		$alm =rdb('mst_anggota','Catatan','Catatan',"where ID='".
			  rdb('inv_penjualan','ID_Anggota','ID_Anggota',"where NoUrut='".$this->no_trans."' and Tanggal='".$this->tgl."'")."'");
		$ncby=rdb('inv_penjualan_jenis','Jenis_Jual','Jenis_Jual',"where ID='".rdb('inv_penjualan','ID_Jenis','ID_Jenis',"where NoUrut='".$this->no_trans."' and Tanggal='".$this->tgl."'")."'");
		$bank=rdb('inv_penjualan','Deskripsi','Deskripsi',"where NoUrut='".$this->no_trans."' and Tanggal='".$this->tgl."'");
		$rek =rdb('inv_penjualan','ID_Post','ID_Post',"where NoUrut='".$this->no_trans."' and Tanggal='".$this->tgl."'");
		$tgir=rdb('inv_penjualan','Tgl_Cicilan','Tgl_Cicilan',"where NoUrut='".$this->no_trans."' and Tanggal='".$this->tgl."'");
		$this->inv_model->tabel('inv_pembayaran');
		$data=$this->inv_model->show_list_1where('no_transaksi',$this->no_trans);
			foreach($data->result() as $row){
				$bawah=str_repeat('-',79).newline().
				sepasi((61-strlen('Sub Total'))).'Sub Total :'.sepasi((14-strlen(number_format($row->total_belanja,2)))).number_format($row->total_belanja,2).newline(2).
				sepasi((61-strlen('Diskon'))).'Diskon :'.sepasi((14-strlen(number_format($row->ppn,2)))).number_format($row->ppn,2).newline().
				sepasi(61).str_repeat('-',18).'+'.newline().
				sepasi((61-strlen('Total'))).'Total :'.sepasi((14-strlen(number_format($row->total_bayar,2)))).number_format($row->total_bayar,2).newline(2).
				sepasi((61-strlen('Uang Muka'))).'Uang Muka :'.sepasi((14-strlen(number_format($row->jml_dibayar,2)))).number_format($row->jml_dibayar,2).newline(2).
				sepasi(61).str_repeat('-',17).'-'.newline().
				sepasi((61-strlen('Sisa'))).'Sisa :'.sepasi((14-strlen(number_format($row->kembalian,2)))).number_format($row->kembalian,2).newline(2).
				str_repeat('-',79).newline().
				'Pembayaran '.sepasi((15-strlen('Pembayaran :'))).':'.$ncby.' No.:'.$rek.' '.$bank .' [ '.tglfromSql($tgir).' ]'.newline().
				'Nama Konsumen'.sepasi((15-strlen('Nama Konsumen :'))).' :'.$nama.'[ '.$urut.' ]'.newline().
				'Alamat'.sepasi((15-strlen('Alamat :'))).' :'.$alm.newline().
				'Terima Kasih.   doc :'.$this->no_trans.' '.date('d-m-Y H:i').newline();
			}
		return $bawah;
	}
	function re_print(){
		system("print ".$this->session->userdata('userid')."_slip.txt");
		system("close");
		$tmpdir=sys_get_temp_dir();
		
		//copy($file, "//localhost/xprinter");  # Lakukan cetak
	}
	//simpan komposisi resep
	function stock_resep(){
		$data=array();
		$data['nm_barang']=strtoupper($_POST['nm_barang']);
		$data['batch']=str_replace('-','',tgltoSql($_POST['batch']));
		$data['expired']=tgltoSql($_POST['expired']);
		$data['stock']=$_POST['stock'];
		$data['blokstok']=$_POST['blokstok'];
		$data['nm_satuan']=$_POST['nm_satuan'];
		$data['harga_beli']=$_POST['harga_beli'];
		$data['created_by']	=$this->session->userdata('userid');
		print_r($data);
		$this->Admin_model->replace_data('inv_material_stok',$data);
	}
	//return penjualan
	
	function return_jual(){
		$data=array();
		$this->zetro_auth->menu_id(array('return_jual'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('penjualan/material_jual_return');
	}
	function get_transaksi(){
		$data=array();
		$no_transaksi=$_POST['no_transaksi'];
		$this->inv_model->tabel('detail_transaksi');
		$data['tgl_transaksi']=tglfromSql($this->Admin_model->show_single_field('detail_transaksi','tgl_transaksi',"where no_transaksi='$no_transaksi'"));
		$data['faktur_transaksi']=$this->Admin_model->show_single_field('detail_transaksi','faktur_transaksi',"where no_transaksi='$no_transaksi'");
		$data['nm_nasabah']=$this->Admin_model->show_single_field('detail_transaksi','nm_produsen',"where no_transaksi='$no_transaksi'");
			echo json_encode($data);
	}
	function get_detail_transaksi(){
		$datax=array();
		$nm_barang=$_POST['nm_barang'];
		$no_transaksi=$_POST['no_transaksi'];
		$this->inv_model->tabel('detail_transaksi');
		$datax=$this->inv_model->detail_transaksi($no_transaksi,$nm_barang);
		echo json_encode($datax[0]);
	}
	function JenisBayar($id_jenis){
		$this->id_jenis=$id_jenis;	
	}
	function process_to_jurnal($id_anggota,$total,$ket='',$lokasi){
	/* membuat data untuk diposting dalam jurnal
	  simpan penjualan barang secara kredit
	  inputnya adalah ID anggota yng melakukan pembelian secara kredit
	  dapatkan ID_Perkiraan dari table perkiraan based on ID_Anggota
	  extract data perkiraan menjadi klass, sub klass dan jenis simpanan dalam hal ini
	  jenis simpanan adalah barang [id:4]
	  data yang dihasilkan akan ditampung di table transaksi_temp
	*/ 
		$data=array();$akun='';
		//get ID_perkiraan
		$akun=rdb('perkiraan','ID','ID',"where ID_Agt='$id_anggota' and ID_Simpanan='".$this->id_jenis."'");
		echo $akun;
		if($akun==''){
			//update database perkiraan
			$this->_update_perkiraan($id_anggota,$this->id_jenis);	
		}
		if($id_anggota==''){
			 if ($this->id_jenis=='5'){
				$idp='27';
			 }else{
				$idp='28';
			 }
		}else{
			$idp='';
		}
		$data['ID_Perkiraan']	=($idp!='')? $idp:rdb('perkiraan','ID','ID',"where ID_Agt='$id_anggota' and ID_Simpanan='".$this->id_jenis."'");
		$data['ID_Unit']		=$lokasi;//rdb('jenis_simpanan','ID_Unit','ID_Unit',"where ID='".$this->id_jenis."'");
		$data['ID_Klas']		=rdb('jenis_simpanan','ID_Klasifikasi','ID_Klasifikasi',"where ID='".$this->id_jenis."'");
		$data['ID_SubKlas']		=rdb('jenis_simpanan','ID_SubKlas','ID_SubKlas',"where ID='".$this->id_jenis."'");
		$data['ID_Dept']		=($idp=='')? '0':rdb('mst_anggota','ID_Dept','ID_Dept',"where ID='".$id_anggota."'");
		if($this->id_jenis!='5'){
			$data['Kredit']		=$total;//rdb('inv_penjualan','Total','Total',"where ID_Anggota='".$id_anggota."' and NoUrut='".$this->no_trans."'");
		}else{
			$data['Debet']		=$total;
		}
		$data['ID_CC']			='1';
		$data['Keterangan']		=($this->id_jenis!='5')?
								 'Penjualan '.rdb('jenis_simpanan','Jenis','Jenis',"where ID='".$this->id_jenis."'").' no. Faktur: '.rdb('inv_penjualan','Nomor','Nomor',"where NoUrut='".$this->no_trans."' and Tanggal='".tgltoSql($this->tgl)."'"):
								 'Pembayaran Retur Barang tanggal '.$this->tgl;
		$data['tanggal']		=tgltoSql($this->tgl);
		$data['ID_Bulan']		=substr($this->tgl,3,2);
		$data['Tahun']			=substr($this->tgl,6,4);
		$data['created_by']		=$this->session->userdata('userid');
		//print_r($data);
		 $this->Admin_model->replace_data('transaksi_temp',$data);
		($this->id_jenis=='2' ||
		 $this->id_jenis=='3' ||
		 $this->id_jenis=='4' )?
		 $this->_set_pinjaman($id_anggota):'';
	}
	
	function _update_perkiraan($ID_Agt,$ID_Simpanan){
		$datax=array();
		$datax['ID_Unit']		=rdb('jenis_simpanan','ID_Unit','ID_Unit',"where ID='".$this->id_jenis."'");
		$datax['ID_Klas']		=rdb('jenis_simpanan','ID_Klasifikasi','ID_Klasifikasi',"where ID='".$this->id_jenis."'");
		$datax['ID_SubKlas']	=rdb('jenis_simpanan','ID_SubKlas','ID_SubKlas',"where ID='".$this->id_jenis."'");
		$datax['ID_Dept']		=rdb('mst_anggota','ID_Dept','ID_Dept',"where ID='".$ID_Agt."'");
		$datax['ID_Simpanan']	=$ID_Simpanan;
		$datax['ID_Agt']		=$ID_Agt;
		$datax['ID_Calc']		=rdb('jenis_simpanan','ID_Calc','ID_Calc',"where ID='".$this->id_jenis."'");
		$datax['ID_Laporan']	=rdb('jenis_simpanan','ID_Laporan','ID_Laporan',"where ID='".$this->id_jenis."'");
		$datax['ID_LapDetail']	=rdb('jenis_simpanan','ID_LapDetail','ID_LapDetail',"where ID='".$this->id_jenis."'");
		echo $this->Admin_model->replace_data('perkiraan',$datax);
		//print_r($datax);
	}
	
	function _set_pinjaman($ID_Agt){
		//penjualan selain tunai akan masuk table pinjaman
		$data=array();
		$data['ID']			=$this->no_trans;
		$data['ID_Agt']		=$ID_Agt;
		$data['ID_Unit']	=rdb('jenis_simpanan','ID_Unit','ID_Unit',"where ID='".$this->id_jenis."'");
		$data['Tanggal']	=tglToSql($this->tgl);
		$data['Tahun']		=substr($this->tgl,6,4);
		$data['jml_pinjaman']=rdb('inv_penjualan','Total','Total',"where NoUrut='".$this->no_trans."' and Tanggal='".tglToSql($this->tgl)."'");
		$data['cara_bayar']	=$this->id_jenis;
		$data['mulai_bayar']=rdb('inv_penjualan','Tgl_Cicilan','Tgl_Cicilan',"where NoUrut='".$this->no_trans."' and Tanggal='".tglToSql($this->tgl)."'");
		$data['keterangan']	=rdb('jenis_simpanan','Jenis','Jenis',"where ID='".$this->id_jenis."'").' No: '.
							 rdb('inv_penjualan','ID_Post',"ID_Post","where NoUrut='".$this->no_trans."' and Tanggal='".tglToSql($this->tgl)."'")."-".
							 rdb('inv_penjualan','Deskripsi','Deskripsi',"where NoUrut='".$this->no_trans."' and Tanggal='".tglToSql($this->tgl)."'").
							 '[ '.tglfromSql(rdb('inv_penjualan','Tgl_Cicilan','Tgl_Cicilan',"where NoUrut='".$this->no_trans."' and Tanggal='".tglToSql($this->tgl)."'")).' ]';
		$this->Admin_model->replace_data('pinjaman',$data);
	}
	function get_bank(){
		$data=array();
		$str	=$_GET['str'];
		$limit	=$_GET['limit'];
		$fld	=rdb('mst_anggota','Nama','Nama',"where ID='".$_GET['fld']."'");
		$data=$this->inv_model->get_bank($str);
		echo json_encode($data);	
	}
	function print_slip_pdf()
	{
/*		$this->no_transaksi($_POST['notrans']);
		$this->tanggal(tgltoSql($_POST['tanggal']));
		*/$data['lokasi']=rdb('user_lokasi','lokasi','lokasi',"where ID='1'");
		$data['no_faktur']='124';//$_POST['faktur'];
/*		$this->inv_model->tabel('inv_penjualan_rekap');
		$data['temp_rec']=$this->kasir_model->get_trans_jual($this->no_trans,$this->tgl);
		//send data to pdf
		$data['cash']=rdb('inv_pembayaran','jml_dibayar','jml_dibayar',"where no_transaksi='".$_POST['notrans']."'");
*/		$this->zetro_auth->menu_id(array('trans_beli'));
		$this->list_data($data);
		$this->View("penjualan/penjualan_slip_t");
	}
	//penerimaan service
	function service()
	{
		$this->zetro_auth->menu_id(array('listservice'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('penjualan/penjuala_service');
	}
	
	function set_service()
	{
		$data=array();$datax=array();
		$data['no_trans']		=$_POST['no_trans'];
		$data['tgl_service']	=tgltoSql($_POST['tgl_service']);
		$data['nm_pelanggan']	=addslashes(strtoupper($_POST['nm_pelanggan']));
		$data['alm_pelanggan']	=empty($_POST['alm_pelanggan'])?'':addslashes(ucwords($_POST['alm_pelanggan']));
		$data['tlp_pelanggan']	=empty($_POST['tlp_pelanggan'])?'':$_POST['tlp_pelanggan'];
		$data['nm_barang']		=addslashes(strtoupper($_POST['nm_barang']));
		$data['merk_barang']	=empty($_POST['tp_barang'])?'':$_POST['tp_barang'];
		$data['noser_barang']	=empty($_POST['no_seri_barang'])?'':$_POST['no_seri_barang'];
		$data['ket_service']	=empty($_POST['ket_barang'])?'':addslashes(ucwords($_POST['ket_barang']));
		$data['masalah_service']=empty($_POST['ket_service'])?'':addslashes(ucwords($_POST['ket_service']));
		$data['gr_service']		=empty($_POST['gr_service'])?'N':$_POST['gr_service'];
		$data['id_lokasi']		=empty($_POST['id_lokasi'])?'1':$_POST['id_lokasi'];
		$data['created_by']		=$this->session->userdata('username');
		SimpanData($this->Admin_model->replace_data('inv_penjualan_service',$data));
		
		$datax['nomor']			=$_POST['no_trans'];
		$datax['jenis_transaksi']='GI';
		$datax['created_by']	=$this->session->userdata('username');
		$this->Admin_model->replace_data('nomor_transaksi',$datax);
	}
	
	function get_detail_service()
	{
		$data=array();
		$where="where no_trans='".$_POST['no_trans']."'";
		$data=$this->Admin_model->show_list('inv_penjualan_service',$where);
		echo json_encode($data[0]);
	}
	
	function get_list_service()
	{
		$data=array();$n=0;
		$where="Where stat_service='N'";
		$where.=empty($_POST['userlok'])?'':" and id_lokasi='".$_POST['userlok']."'";
		$orderby='';
		$data=$this->Admin_model->show_list('inv_penjualan_service',$where.$orderby);
		$cek_oto=$this->zetro_auth->cek_oto('e','listservice');
		foreach($data as $r)
		{
			$n++;
			echo tr().td($n,'center').
				 td($r->no_trans,'center').
				 td(tglfromSql($r->tgl_service),'center').
				 td($r->nm_pelanggan).
				 td($r->alm_pelanggan.' '.$r->tlp_pelanggan).
				 td($r->nm_barang).
				 td($r->gr_service,'center').
				 td(rdb('user_lokasi','lokasi','lokasi',"where ID='".$r->id_lokasi."'")).
				 td(($cek_oto!='' && $r->stat_service=='N')?img_aksi($r->no_trans,true):'','center').
				_tr();	
		}
		dataNotFound($data,9);
	}
	
	function del_service()
	{
		$no_trans=$_POST['id'];
		$this->Admin_model->hps_data('inv_penjualan_service',"where no_trans='".$no_trans."'");	
	}
}
?>