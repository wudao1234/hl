package org.mstudio.modules.wms.common;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.lang.Snowflake;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.sax.handler.RowHandler;
import org.apache.tomcat.util.http.fileupload.FileUploadBase;
import org.mstudio.exception.BadRequestException;
import org.mstudio.utils.FileUtil;
import org.springframework.http.HttpHeaders;
import org.springframework.web.multipart.MultipartFile;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author Macrow
 * @date 2019-03-26
 */
public class WmsUtil {

    /**
     * 默认大小 50M
     */
    public static final long DEFAULT_MAX_SIZE = 52428800;
    public static final String ORDER_SN_BASE = "00000";
    public static final String ORDER_SN_START = "00001";
    private static int counter = 0;

    private static final Snowflake SNOWFLAKE = IdUtil.createSnowflake(1, 1);

    public static ResultMessage getSuccessMessage() {
        return new ResultMessage("操作成功", 0, 0);
    }

    public static ResultMessage getResultMessage(int countSucceed, int countFailed) {
        return new ResultMessage("操作完成", countSucceed, countFailed);
    }

    public static ResultMessage getResultMessage(MultiOperateResult result) {
        return new ResultMessage("操作完成", result.getCountSucceed(), result.getCountFailed());
    }

    public static HttpHeaders getExportExcelHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.setAccessControlExposeHeaders(Collections.singletonList("Content-Disposition"));
        headers.set("Content-Disposition", "attachment; filename=exportFile.xlsx");
        headers.setAccessControlExposeHeaders(Collections.singletonList("Content-Type"));
        headers.set("Content-Type", "application/vnd.ms-excel");
        return headers;
    }

    public static String uploadExcelFile(String uploadPath, MultipartFile excelFile) throws Exception {
        String path = FileUtil.getUploadPath(uploadPath);
        String suffix = "." + excelFile.getOriginalFilename().substring(excelFile.getOriginalFilename().lastIndexOf(".") + 1);
        if (!excelFile.getOriginalFilename().matches("^.+\\.(?i)(xls)$") && !excelFile.getOriginalFilename().matches("^.+\\.(?i)(xlsx)$")) {
            throw new BadRequestException("上传文件格式不正确");
        }
        return FileUtil.upload(path, excelFile, suffix);
    }

    public static String uploadHtmlFile(String uploadPath, MultipartFile htmlFile) throws Exception {
        String path = FileUtil.getUploadPath(uploadPath);
        String suffix = "." + htmlFile.getOriginalFilename().substring(htmlFile.getOriginalFilename().lastIndexOf(".") + 1);
        if (!htmlFile.getOriginalFilename().matches("^.+\\.(?i)(html)$") && !htmlFile.getOriginalFilename().matches("^.+\\.(?i)(htm)$")) {
            throw new BadRequestException("上传文件格式不正确");
        }
        return FileUtil.upload(path, htmlFile, suffix);
    }

    public static String uploadImageFile(String uploadPath, MultipartFile imageFile) throws Exception {
        String path = FileUtil.getUploadPath(uploadPath);
        String suffix = "." + imageFile.getOriginalFilename().substring(imageFile.getOriginalFilename().lastIndexOf(".") + 1);
        if (!imageFile.getOriginalFilename().matches("^.+\\.(?i)(jpg)$") && !imageFile.getOriginalFilename().matches("^.+\\.(?i)(png)$")
                && !imageFile.getOriginalFilename().matches("^.+\\.(?i)(bmp)$")) {
            throw new BadRequestException("只接受 jpg, png, bmp 图片格式");
        }
        String imageFileName = FileUtil.upload(path, imageFile, suffix);
        return imageFileName;
    }


    /**
     * 编码文件名
     */
    private static String encodingFilename(String filename, String extension) {
        filename = filename.replace("_", " ");
        String mix = FileUtil.hash(filename + System.nanoTime() + counter++);
        filename = generateTimeStampSN() + mix.substring(mix.length() - 5) + extension;
        return filename;
    }

    /**
     * 文件大小校验
     *
     * @param file 上传的文件
     * @return
     * @throws FileUploadBase.FileSizeLimitExceededException 如果超出最大大小
     */
    public static void assertAllowed(MultipartFile file) throws FileUploadBase.FileSizeLimitExceededException {
        long size = file.getSize();
        if (size > DEFAULT_MAX_SIZE) {
            throw new FileUploadBase.FileSizeLimitExceededException("上传文件大小超过限制", size, DEFAULT_MAX_SIZE);
        }
    }

    public static Boolean isValidDateInKingdeeExcel(Object object) {
        if (object == null) {
            return false;
        }
        boolean convertSuccess = true;
        SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
        try {
            format.setLenient(false);
            format.parse(object.toString());
        } catch (ParseException e) {
            convertSuccess = false;
        }
        return convertSuccess;
    }

    public static String generateSnowFlakeId() {
        // 生成6位时间戳，替换雪花ID的前6位，生成流水号
        String dateString = DateUtil.format(new Date(), "YYYYMMdd").substring(2);
        String snowFlakeString = String.valueOf(SNOWFLAKE.nextId()).substring(6);
        return dateString + snowFlakeString;
    }

    synchronized public static String generateTimeStampSN() {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyMMddHHmmssSSS");
        String timeStampStr = simpleDateFormat.format(new Date());
        // 返回15位时间数字+3位随机数
        Random random = new Random();
        DecimalFormat decimalFormat = new DecimalFormat("000");
        String randomStr = decimalFormat.format(random.nextInt(999));
        return timeStampStr + randomStr;
    }

    public static String generateUuidSn() {
        int machineId = 1;
        int hashCodeV = UUID.randomUUID().toString().hashCode();
        if (hashCodeV < 0) {
            hashCodeV = -hashCodeV;
        }
        return machineId + String.format("%015d", hashCodeV);
    }

    synchronized public static String getNewSn(String prefix, String oldSn, Boolean useNewAutoIncreaseSn) {
        String newSn = ORDER_SN_START;
        if (useNewAutoIncreaseSn || oldSn == null || oldSn.isEmpty()) {
            return prefix + newSn;
        } else {
            String regEx = "[^0-9]";
            Pattern p = Pattern.compile(regEx);
            Matcher m = p.matcher(oldSn);
            oldSn = m.replaceAll("").trim();
            if (!oldSn.isEmpty()) {
                //int newNumber = Integer.parseInt(oldSn) + 1;
                Long newNumber = Long.parseLong(oldSn) + 1;
                newSn = String.format(prefix + "%05d", newNumber);
            }
            return newSn;
        }
    }

    public static boolean isExcel03(String fileName) {
        boolean isExcel2003 = true;
        if (fileName.matches("^.+\\.(?i)(xlsx)$")) {
            isExcel2003 = false;
        }
        return isExcel2003;
    }

    public static void handleExcelFile(String fileName, RowHandler handler) {
        if (isExcel03(fileName)) {
            ExcelUtil.read03BySax(fileName, 0, handler);
        } else {
            ExcelUtil.read07BySax(fileName, 0, handler);
        }
    }

    public static String getSearchString(String search) {
        return "%" + search.trim() + "%";
    }


    public static Integer getFirstNumbersFromString(String content) {
        String regEx = "[^0-9]+";
        Pattern pattern = Pattern.compile(regEx);
        //用定义好的正则表达式拆分字符串，把字符串中的数字留出来
        String[] cs = pattern.split(content);
        if (cs.length > 0 && !StrUtil.isEmptyOrUndefined(cs[0])) {
            return Integer.parseInt(cs[0]);
        }
        return 0;
    }

    public static String[] intersect(String[] arr1, String[] arr2) {
        List<String> l = new LinkedList<>();
        Set<String> common = new HashSet<>();
        for (String str : arr1) {
            if (!l.contains(str)) {
                l.add(str);
            }
        }
        for (String str : arr2) {
            if (l.contains(str)) {
                common.add(str);
            }
        }
        String[] result = {};
        return common.toArray(result);
    }
}
