<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
$zfm=new zetro_frmBuilder('asset/bin/zetro_neraca.frm');
$zlb=new zetro_buildlist();
$zlb->config_file('asset/bin/zetro_neraca.frm');
$path='application/views/laporan/transaksi';
calender();
$modul=$this->session->userdata('menus');
link_css('jquery.coolautosuggest.css','asset/css');
link_js('jquery.coolautosuggest.js','asset/js');
link_js('auto_sugest.js,lap_jual.js,jquery.fixedheader.js','asset/js,'.$path.'/js,asset/js');
panel_begin('Detail Penjualan');
panel_multi('detailpenjualan','block',false);
if($all_detailpenjualan!=''){
	echo "<form id='frm1' name='frm1' method='post' action=''>";
	addText(array('Lokasi  '.nbs(2)),array("<select id='id_lokasi' name='id_lokasi'></select>"));
	addText(array('Periode Dari  '.nbs(1),' s/d '),
			array("<input type='text' id='dari_tgl' name='dari_tgl' value=''>",
		  		  "<input type='text' id='sampai_tgl' name='sampai_tgl' value=''>
		 			<!--input type='button' value='OK' id='okelah'/-->
		  			<input type='hidden' value='1' id='jenis_beli' name='jenis_beli'/>"));
	addText(array('Kategori'.nbs(2)),array("<select id='kategori' name='kategori'></select>"));
	addText(array('Pembayaran    '.nbs(1)),array("<select id='id_jenis' name='id_jenis'></select>"));
	addText(array('Order by'.nbs(2)),array("<select id='orderby' name='orderby'>".selectTxt('SusunanKredit',false,'asset/bin/zetro_member.frm')."</select>"));
	addText(array('Sort by '.nbs(2)),array("<select id='urutan' name='urutan'>".selectTxt('Urutan',false)."</select>"));
	addText(array(($modul=='S2FzaXI=')?
					'Show Detail Transaksi':'',''),array(($modul=='S2FzaXI=')? "<input type='checkbox' id='show_de' name='show_de' value='detail' style='display:none'>":"",
					"<input type='button' value='Proses' id='okedech'/>"));
/*	addText(array('Periode  :',' s/d ','Jenis Penjualan',''),
	array("<input type='text' id='dari_tgl' name='dari_tgl' value=''>",
		  "<input type='text' id='sampai_tgl' name='sampai_tgl' value=''>",
		  "<select id='id_jenis' name='id_jenis'></select>",
		  "<!--input type='button' value='OK' id='okelah'-->"));
	addText(array('Order by :','Sort by','',''),
			array("<select id='orderby' name='orderby'>".selectTxt('susunanjual',false,'asset/bin/zetro_member.frm')."</select>",
				  "<select id='urutan' name='urutan'>".selectTxt('Urutan',true)."</select>",
				  "<input type='checkbox' id='show_de' name='show_de' checked='checked' value='detail' style='display:none'>",
				  "<input type='button' value='OK' id='okedech'/>"));
*/	echo "</form>";
	echo "</tbody></table>";
	echo "<table id='xx' width='100%'><tbody><tr><td>&nbsp;</td></tr></tbody></table>";
}else{
	no_auth();
}
panel_multi_end();
auto_sugest();
panel_end();
$lokasi=$this->zetro_auth->cek_area();
?>
<input type='hidden' value="<?=$this->session->userdata('menus');?>" id='aktif'/>
<script language="javascript">
$(document).ready(function(e) {
	$('#id_lokasi').html("<option value='' selected>Semua</option><? dropdown('user_lokasi','ID','Lokasi',"where ID in(".$lokasi.") order by ID",'');?>");
	$('#kategori').html("<option value='' selected>Semua</option><? dropdown('inv_barang_kategori','ID','Kategori','','');?>");
	$('#id_jenis').html("<option value=''>Semua</option><? dropdown('inv_penjualan_jenis','ID','Jenis_Jual','','');?>");
    $('#detailpenjualan').removeClass('tab_button');
	$('#detailpenjualan').addClass('tab_select');
});
</script>
