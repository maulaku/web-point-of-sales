<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
$zfm=new zetro_frmBuilder('asset/bin/zetro_neraca.frm');
$zlb=new zetro_buildlist();
$zlb->config_file('asset/bin/zetro_neraca.frm');
$path='application/views/warehouse';
$sesi=$this->session->userdata('menus');
link_js('jquery.fixedheader.js','asset/js');
link_js('material_stocklist.js',$path.'/js');
calender();
panel_begin(($sesi!='SW52ZW50b3J5')?'List Stock':'Stock Adjustment');
panel_multi(($sesi!='SW52ZW50b3J5')?'liststock':'stockadjustment','block',false);
if($all_liststock!='' || $all_stockadjustment!=''){
	echo "<form id='frm1' name='frm1' method='post' action=''>";
	addText(array('Kategori','Lokasi','Order By','Urutan','',''),
			array("<select id='Kategori' name='Kategori'></select>",
				  "<select id='id_lokasi' name='id_lokasi'></select>",
				  "<select id='Stat' name='Stat' style='display:none'>
					  <option value=''>Semua</option>
					  <option value='Continue'>Continue</option>
					  <option value='Discontinue'>Discontinue</option>
				  </select>
				  <select id='orderby' name='orderby'>".selectTxt('SusunanStock')."</select>",
				  "<select id='urutan' name='urutan'>".selectTxt('Urutan',true)."</select>",
				  "<input type='button' value='OK' id='okelah'/>",
				  "<input type='button' value='Print' id='prt'/>"));
	echo "</form>";
		$zlb->section('stocklist');
		$zlb->aksi(($sesi!='SW52ZW50b3J5')?false:($e_stockadjustment!='')?true:false);//SW52ZW50b3J5
		$zlb->icon();
		$zlb->Header('100%','stoked');
	echo "</tbody></table>";
}else{
	 no_auth();
}

panel_multi_end();
panel_end();
popup_start('stocklist','Stock Adjustment',550);
$fld="<input type='hidden' id='id_barang' val=''/>";
$fld.="<input type='hidden' id='batch' val=''/>";
	$zfm->Addinput($fld);
	$zfm->AddBarisKosong(true);
	$zfm->Start_form(true,'frm2');
	$zfm->BuildForm('stockadjust',true,'100%');
	$zfm->BuildFormButton('Simpan','edit_mat');
popup_end();
?>
<input type='hidden' value='<?=$e_stockadjustment;?>' id='edited' />
<input type='hidden' value='' id='lokasi' />
<script language="javascript">
$(document).ready(function(e) {
    $('#Kategori').html("<? dropdown('inv_barang_kategori','ID','Kategori','order by Kategori','17');?>")
    $('#id_lokasi').html("<? dropdown('user_lokasi','ID','lokasi','order by id',$this->session->user);?>")
	$('#okelah').click();
    $('#stockadjustment').removeClass('tab_button');
	$('#stockadjustment').addClass('tab_select');
});


</script>
