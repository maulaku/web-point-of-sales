<?php
$zfm=new zetro_frmBuilder('asset/bin/zetro_master.frm');
$section='Barang';
$zlb=new zetro_buildlist();
$zlb->config_file('asset/bin/zetro_master.frm');
$path='application/views/controlpanel';
link_js('jquery.fixedheader.js,karyawan.js','asset/js,'.$path.'/js');
tab_select('');
panel_begin('Karyawan');
panel_multi('listkaryawan','block',false);
if($all_controlpanel__karyawan!=''){
	   ($c_controlpanel__karyawan!='')?addText(array("<input type='button' id='addkaryawan' value='Tambah Karyawan Baru'/>"),array('')):'';
	   addText(array('Lokasi',''),
	   		   array("<select id='userlok' name='userlok'></select>",
			   		 "<input type='button' id='ok' value='OK'>"));
		$zlb->section('Karyawan');
		$zlb->aksi(true);
		$zlb->icon();
		$zlb->Header('100%');
		echo _tabel(true);
}else{
	no_auth();
}
panel_multi_end();
popup_start('addnew','Tambah Karyawan Baru');
	$zfm->Addinput("<input type='hidden' id='ID' name='ID' value=''/>");
	$zfm->AddBarisKosong(true);
	$zfm->Start_form(true,'frm3');
	$zfm->BuildForm('Karyawan',true,'100%');
	$zfm->BuildFormButton('Simpan','person');
popup_end();
panel_end();
?>
<script language="javascript">
	$(document).ready(function(e) {
    $('#userlok')
		.html("<? dropdown('user_lokasi','ID','lokasi',"where id in(".$this->zetro_auth->cek_area().") order by id",$this->session->userdata('gudang'));?>")
  		.val($('#lok').val()).select()
    $('#ID_Dept')
		.html("<? dropdown('user_lokasi','ID','lokasi',"where id in(".$this->zetro_auth->cek_area().") order by id",$this->session->userdata('gudang'));?>")
  		
	//disabled jika satu lokasi
	 if($('#jml_area').val()=='1')
	 { 
	 	lock('#userlok');
		lock('#ID_Dept')
	 }else{
		 unlock('#userlok');
		 unlock('#ID_Dept')
	 }
	  $('#ok').click();
    });

</script>
