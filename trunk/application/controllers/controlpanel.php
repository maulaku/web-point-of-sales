<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
Class name: User Control
version : 1.0
Author : Iswan Putera
*/

class Controlpanel extends CI_Controller {
	public $userid;
	function __construct(){
		parent::__construct();
		$this->load->model("Admin_model");
		$this->load->model("control_model");
		$this->load->library("zetro_auth");
		$this->load->library("zetro_manager");
		$this->userid=$this->session->userdata('idlevel');
	}
	
	function Header(){
		$this->load->view('admin/header');	
	}
	
	function Footer(){
		$this->load->view('admin/footer');	
	}
	function list_data($data){
		$this->data=$data;
	}
	function View($view){
		$this->Header();
		//$this->zetro_auth->view($view);
		$this->load->view($view,$this->data);	
		$this->Footer();
	}
	function userlist(){
		$this->zetro_auth->menu_id(array('adduser','listuser','authorisation'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('controlpanel/userlist');

	}
	function change_password(){
		$this->zetro_auth->menu_id(array('adduser','listuser','authorisation'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('controlpanel/change_password');
	}
	function get_modul(){
		$jml=0;
		$path="asset/bin/zetro_menu.dll";
		$jml=$this->zetro_manager->Count('Menu Utama',$path);
		echo $jml;
		for ($i=1;$i<=$jml;$i++){
			$txt=explode('|',$this->zetro_manager->rContent('Menu Utama',$i,$path));
			$selected=(base64_encode($txt[0])==$this->session->userdata('menus'))?'selected':'';
				echo "<option value='".$txt[0]."' $selected>".$txt[0]."</option>";
		}
			
	}
	function get_data_head(){
		$modul=empty($_POST['modul'])?base64_decode($this->session->userdata('menus')):$_POST['modul'];
		tab_head($modul,'','asset/bin/zetro_menu.dll');
		echo "<table id='usrmenu' style='border-collapse:collapse' width='70%'>\n
			 <thead>
			 <tr class='header' align='center'>
			 <th class='kotak' width='30%'>".base64_decode($this->session->userdata('menus'))."</th>
			 <th class='kotak' width='8%'>Input</th>
			 <th class='kotak' width='8%'>Edit</th>
			 <th class='kotak' width='8%'>View</th>
			 <th class='kotak' width='8%'>Print</th>
			 </tr></thead><tbody>\n
			 </tbody></table>\n";
		tab_head_end();
	}
	function get_tab_content(){
		$section=empty($_POST['section'])?base64_decode($this->session->userdata('menus')):$_POST['section'];
		$this->set_config_file('asset/bin/zetro_menu.dll');
		$mnu=explode('|',$this->zetro_manager->rContent($section,1,$this->filename));
		$submodul=($mnu[2]=='')? explode('|',$this->zetro_manager->rContent($section,2,$this->filename)):explode('|',$this->zetro_manager->rContent($section,1,$this->filename));
		echo $submodul[0];
	}
	function get_data_menu(){
		$nmgrp=empty($_POST['nm_group'])?$this->session->userdata('idlevel'):$_POST['nm_group'];
		$section=$_POST['section'];
		$this->set_config_file('asset/bin/zetro_menu.dll');
		$jml_sec=$this->zetro_manager->Count($section,$this->filename);	
		for ($i=1;$i<=$jml_sec;$i++){
			$mnu=explode('|',$this->zetro_manager->rContent($section,"$i",$this->filename));
			$jml_sub=$this->zetro_manager->Count($mnu[0],$this->filename);
			($jml_sub>0)?$warna="bgcolor='#89E0EA'":$warna='';
		if($mnu[1]!="x"){
		 	echo "<tr id='".$mnu[0]."' align='center' class='xx'>
		  		<td class='kotak' align='left' $warna;><img src='".base_url()."asset/images/bullet2.png'>&nbsp;".$mnu[0]."</td>\n";
			echo ($jml_sub==0)? 
			   "<td class='kotak'><input type='checkbox' id='c-".str_replace('/','__',$mnu[1])."' value='c-".$mnu[1]."' onclick=\"mnu_onClick('c','".str_replace('/','__',$mnu[1])."');\"".$this->control_model->cek_oto_x('c',$mnu[1],$nmgrp)." ".$this->zetro_auth->lock('c','authorisation')." ".$this->un_required($mnu[3],'c')."></td>\n
				<td class='kotak'><input type='checkbox' id='e-".str_replace('/','__',$mnu[1])."' value='e-".$mnu[1]."' onclick=\"mnu_onClick('e','".str_replace('/','__',$mnu[1])."');\"".$this->control_model->cek_oto_x('e',$mnu[1],$nmgrp)." ".$this->zetro_auth->lock('c','authorisation')." ".$this->un_required($mnu[3],'e')."></td>\n
				<td class='kotak'><input type='checkbox' id='v-".str_replace('/','__',$mnu[1])."' value='v-".$mnu[1]."' onclick=\"mnu_onClick('v','".str_replace('/','__',$mnu[1])."');\"".$this->control_model->cek_oto_x('v',$mnu[1],$nmgrp)." ".$this->zetro_auth->lock('c','authorisation')." ".$this->un_required($mnu[3],'v')."></td>\n
				<td class='kotak'><input type='checkbox' id='p-".str_replace('/','__',$mnu[1])."' value='p-".$mnu[1]."' onclick=\"mnu_onClick('p','".str_replace('/','__',$mnu[1])."');\"".$this->control_model->cek_oto_x('p',$mnu[1],$nmgrp)." ".$this->zetro_auth->lock('c','authorisation')." ".$this->un_required($mnu[3],'p')."></td>\n":
				"<td class='kotak' colspan='4' $warna;>&nbsp;</td>\n";
			echo "</tr>\n";
		}
			if($jml_sub>0){
				for ($z=1;$z<=$jml_sub;$z++){
					$sub_mnu=explode('|',$this->zetro_manager->rContent($mnu[0],"$z",$this->filename));
					echo "<tr id='".$mnu[0]."' class='".$sub_mnu[0]." xx' align='center'>
						  <td class='kotak' align='left'>".str_repeat('&nbsp;',5).
						  "<img src='".base_url()."asset/images/16/clipboard_16.png'>&nbsp;".$sub_mnu[0]."</td>\n
						  <td class='kotak'><input type='checkbox' id='c-".str_replace('/','__',$sub_mnu[1])."' value='c-".$mnu[1]."' onclick=\"mnu_onClick('c','".str_replace('/','__',$sub_mnu[1])."');\"".$this->control_model->cek_oto_x('c',$sub_mnu[1],$nmgrp)." ".$this->zetro_auth->lock('c','authorisation')." ".$this->un_required($sub_mnu[3],'c')."></td>\n
						  <td class='kotak'><input type='checkbox' id='e-".str_replace('/','__',$sub_mnu[1])."' value='e-".$mnu[1]."' onclick=\"mnu_onClick('e','".str_replace('/','__',$sub_mnu[1])."');\"".$this->control_model->cek_oto_x('e',$sub_mnu[1],$nmgrp)." ".$this->zetro_auth->lock('c','authorisation')." ".$this->un_required($sub_mnu[3],'e')."></td>\n
						  <td class='kotak'><input type='checkbox' id='v-".str_replace('/','__',$sub_mnu[1])."' value='v-".$mnu[1]."' onclick=\"mnu_onClick('v','".str_replace('/','__',$sub_mnu[1])."');\"".$this->control_model->cek_oto_x('v',$sub_mnu[1],$nmgrp)." ".$this->zetro_auth->lock('c','authorisation')." ".$this->un_required($sub_mnu[3],'v')."></td>\n
						  <td class='kotak'><input type='checkbox' id='p-".str_replace('/','__',$sub_mnu[1])."' value='p-".$mnu[1]."' onclick=\"mnu_onClick('p','".str_replace('/','__',$sub_mnu[1])."');\"".$this->control_model->cek_oto_x('p',$sub_mnu[1],$nmgrp)." ".$this->zetro_auth->lock('c','authorisation')." ".$this->un_required($sub_mnu[3],'p')."></td>\n
						  </tr>\n";
					}
			}
		}
	}
	
	function set_config_file($filename){
		$this->filename=$filename;
	}
	
	function cek_oto($field,$menu,$userid=''){
		($userid=='')?
		$this->control_model->userid=$this->userid:
		$this->control_model->userid=$userid;
		$datax=$this->control_model->cek_oto($field,str_replace('/','__',$menu));
		return $datax;
	}
	function lock($field,$menu,$visibiliti){
		if($this->userid!='1'){
		return($this->cek_oto($field,$menu,$this->userid)=='')? " disabled='disabled'":'';	
		}
	}
	
	function un_required($idmenu,$field){
		$datax=false;
		$datax=strpos($idmenu,$field);
		return($datax==true)?'':" disabled='disabled'";
	}	
		
	function get_userid(){
		$str=addslashes($_POST['str']);
		$induk=$_POST['induk'];
		$fld='userid';
		$this->control_model->tabel('users');
		$this->control_model->field($fld);
		$datax=$this->control_model->auto_sugest($str);
		if($datax->num_rows>0){
			echo "<ul>";
				foreach ($datax->result() as $lst){
					echo '<li onclick="suggest_click(\''.$lst->$fld.'\',\'userid\',\''.$induk.'\');">'.$lst->$fld."</li>";
				}
			echo "</ul>";
		}		
	}
	
	function simpan_newuser(){
		$data=array();
		$data['userid']=$_POST['userid'];
		$data['username']=addslashes($_POST['username']);	
		$data['idlevel']=$_POST['idlevel'];	
		$data['password']=md5($_POST['password']);	
		$data['active']='Y';
		$data['lokasi']=empty($_POST['lokasi'])?'1':$_POST['lokasi'];
		$this->Admin_model->replace_data('users',$data); //insert data mode replace if exists
		//add new user to list 
		$this->get_userlist();
	}
	function get_userlist(){
		$this->zetro_buildlist->config_file('asset/bin/zetro_user.frm');
		$btn=($this->cek_oto('e','listuser')=='')? false:true;
			$sql2="select * from users where userid !='superuser' order by userid";
			$this->zetro_buildlist->deskripsi('user_level','nmlevel','idlevel');
			$this->zetro_buildlist->section('userlist');
			$this->zetro_buildlist->aksi($btn);
			$this->zetro_buildlist->icon();
			$this->zetro_buildlist->query($sql2);
			$this->zetro_buildlist->list_data('userlist');
			$this->zetro_buildlist->BuildListData('userid');
	}
	function hapus_user(){
		$userid=$_POST['userid'];
		$this->control_model->hapus_table('users','userid',$userid);	
	}
	
	function simpan_newlevel(){
		$data=array();
		$data['nmlevel']=$_POST['nmlevel'];	
		$this->Admin_model->replace_data('user_level',$data);
		$pilih=$this->Admin_model->show_single_field('user_level','idlevel',"order by idlevel");
		dropdown('user_level','idlevel','nmlevel',"where idlevel!='1' order by nmlevel",$pilih);
	}
	
	function get_datauser(){
		$data=array();
		$userid=$_POST['userid'];
		$data['username']=$this->Admin_model->show_single_field('users','username',"where userid='$userid'");
		$data['idlevel'] =$this->Admin_model->show_single_field('users','idlevel',"where userid='$userid'");
		$data['lokasi'] =$this->Admin_model->show_single_field('users','lokasi',"where userid='$userid'");
		echo json_encode($data);
	}
	function set_userupdate(){
		$data=array();
		$data['username']	=addslashes($_POST["username"]);
		$data['idlevel']	=$_POST["idlevel"];
		$data['lokasi']		=$_POST["lokasi"];
			$this->Admin_model->update_table('users','userid',$_POST["userid"],$data);
			$this->get_userlist();
	}
	//change password
	function cek_password(){
		$old_pwd=$_POST['old_pwd'];
		$data=$this->Admin_model->cek_pwd();
		echo (md5($old_pwd)==$data)?'OK':'NO';
	}
	function update_password(){
		$data=array();$datax='0';
		$data['password']=md5($_POST["new_pwd"]);
		$datax=$this->Admin_model->update_table('users','userid',$this->session->userdata('userid'),$data);
		echo $datax;	
	}
	//authorisation update
	function useroto_update(){
		$data	=array();
		$field	=$_POST['idfld'];
		$stat	=$_POST['stat'];
		$idmenu	=$_POST['idmenu'];
		$uid	=$_POST['userid'];
		$data['userid']	=$_POST['userid'];
		$data['idmenu']	=$_POST['idmenu'];
		$data[$field]	=$stat;
		//cek data apakah sudah terdapat di db user oto
		//jika belum create new dan jika sudah update field
		/*$this->Admin_model->replace_data('useroto',$data);*/
		$cekk=$this->Admin_model->field_exists('useroto',"where idmenu='$idmenu' and userid='$uid'","idmenu");
		($cekk!='')?
		$this->Admin_model->upd_data('useroto',"set $field='$stat'","where idmenu='$idmenu' and userid='$uid'"):
		$this->Admin_model->simpan_data('useroto',$data); 
		//echo $cekk."//".$_POST['idmenu'];	
		//print_r($data);
	}
	function user_oto_lokasi(){
		$data=array();
		$data['userid']	=$_POST['userid'];
		$data['lokasi']	=$_POST['area'];
		$data['c']		=$_POST['stat'];	
		$this->Admin_model->replace_data('user_oto_area',$data);
	}
	//karywan
	function karyawan()
	{
		$this->zetro_auth->menu_id(array('controlpanel__karyawan'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('controlpanel/karyawan');
	}
	
	function set_karyawan()
	{
		$data=array();
		$data['ID']		=empty($_POST['ID'])?'0':$_POST['ID'];
		$data['Nama']	=strtoupper(addslashes($_POST['Nama']));
		$data['ID_Dept']=empty($_POST['ID_Dept'])?'1':$_POST['ID_Dept'];
		$data['NIP']	=empty($_POST['NoUrut'])?'':$_POST['NoUrut'];
		$data['ID_Kelamin']=empty($_POST['ID_Kelamin'])?'':$_POST['ID_Kelamin'];
		$data['ID_Jenis']='5';
		$data['Kota']	=' ';
		$data['Propinsi']=' ';
		$this->Admin_model->replace_data('mst_anggota',$data);
	}
	
	function get_detail_karyawan()
	{
		$data=array();
		$id=$_POST['id'];
		$data=$this->control_model->detail_karyawan($id);
		echo json_encode($data);
	}
	function get_list_karyawan()
	{
		$file='asset/bin/zetro_master.frm';
		$data=array();$n=0;
		$where=empty($_POST['id_lokasi'])?'':"where ID_Dept='".$_POST['id_lokasi']."' and ID_Jenis='5'";
		$data=$this->Admin_model->show_list('mst_anggota',$where);
		$oto=$this->zetro_auth->cek_oto('e','controlpanel__karyawan');
		if($data){
			foreach($data as $r)
			{
				$n++;$sex='';
				$sex=explode(',',$this->zetro_manager->rContent('Sex',$r->ID_Kelamin,$file));
				echo tr().td($n,'center').
					 td($r->NIP,'center').
					 td($r->Nama).
					 td($sex[1],'center').
					 td(rdb('user_lokasi','lokasi','lokasi',"where ID='".$r->ID_Dept."'")).
					 td(($oto!='')?img_aksi($r->ID,true):'','center').
					_tr();
			}
		}else{
			echo tr().td('Belum ada data karyawan','left\' colspan=\'6')._tr();	
		}
		echo $where;
	}
	function del_karyawan()
	{
		$id=$_POST['id'];
		$this->Admin_model->hps_data('mst_anggota',"where ID='".$id."'");
	}
	
	//absensi
	
	function absensi()
	{
		$this->zetro_auth->menu_id(array('controlpanel__absensi'));
		$this->list_data($this->zetro_auth->auth());
		$this->View('controlpanel/absensi');
	}
	function get_daily_absen()
	{
		$data=array();$n=0;
		$where=empty($_POST['id_lokasi'])?"'Where ID_Jenis='5'":"where ID_Jenis='5' and ID_Dept='".$_POST['id_lokasi']."'";
		$data=$this->Admin_model->show_list('mst_anggota',$where." order by Nama");
		foreach($data as $r)
		{
			$n++;
			$cekAbsen='';$stato="";
			$cekAbsen=rdb('absensi','on_absen','on_absen',"where id_karyawan='".$r->ID."' and tgl_absen='".date('Ymd')."'");
			$stato=($cekAbsen=='Y')?"checked='checked'":'';
			echo tr().td($n,'center').
				 td($r->Nama).
				 td("<input type='checkbox' style='cursor:pointer' id='r-".$r->ID."' name='r-".$r->ID."' $stato><label> Hadir</label>",'center').
				 _tr();
		}
		
	}
	function set_absensi()
	{
		$data=array();
		$data['id_karyawan']=$_POST['id_karyawan'];
		$data['tgl_absen']	=tgltoSql($_POST['tgl_absen']);
		$data['on_absen']	=empty($_POST['on_absen'])?'N':$_POST['on_absen'];
		$data['id_lokasi']	=empty($_POST['id_lokasi'])?'1':$_POST['id_lokasi'];
		echo($this->Admin_model->replace_data('absensi',$data))?
			img_aksi('',true,'info')." Data berhasil di simpan":
			img_aksi('',true,'warning').' '.mysql_error();
	}
	function get_detail_absensi()
	{
		$data=array();
		$id=$_POST['id'];
		$bln=empty($_POST['bln'])?date('m'):$_POST['bln'];
		$thn=empty($_POST['thn'])?date('Y'):$_POST['thn'];
		$where="where id='".$id."' month(tgl_absen)='".$bln."' and year(tgl_absen)='".$thn."'";
		$data=$this->Admin_model->show_list('absensi',$where);
		$data=(is_array($data))?$data[0]:array('id_karyawan'=>'','tgl_absen'=>'');
		echo json_encode($data);
	}
	
	function get_list_absensi()
	{	
		$data=array();$n=0;
		$lok=empty($_POST['id_lokasi'])?'':$_POST['id_lokasi'];
		$bln=empty($_POST['bln'])?date('m'):$_POST['bln'];
		$thn=empty($_POST['thn'])?date('Y'):$_POST['thn'];
		$where="where month(tgl_absen)='".$bln."' and year(tgl_absen)='".$thn."'";
		$where.=($lok=='')?'':" and id_lokasi='".$lok."'";
		$data=$this->Admin_model->show_list('absensi',$where." order by tgl");
		foreach($data as $r)
		{
			$n++;
			echo tr().td($n,'center').
				 td(rdb('mst_anggota','Nama','Nama',"where ID='".$r->id_karyawan."'")).
				 td().
				 td().
				_tr();	
		}
	}
}
?>
