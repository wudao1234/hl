package org.mstudio.utils;

import cn.hutool.core.util.IdUtil;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;
import org.apache.tomcat.util.http.fileupload.FileUploadBase;
import org.mstudio.exception.BadRequestException;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

import static cn.hutool.core.convert.Convert.toHex;
import static cn.hutool.crypto.digest.DigestUtil.md5;

/**
 * File工具类，扩展 hutool 工具包
 *
 * @date 2018-12-27
 */
@Slf4j
public class FileUtil extends cn.hutool.core.io.FileUtil {

    /**
     * 定义GB的计算常量
     */
    private static final int GB = 1024 * 1024 * 1024;
    /**
     * 定义MB的计算常量
     */
    private static final int MB = 1024 * 1024;
    /**
     * 定义KB的计算常量
     */
    private static final int KB = 1024;

    /**
     * 50M 文件大小限制
     */
    private static final int DEFAULT_MAX_SIZE = 52428800;

    private static int counter = 0;

    /**
     * 格式化小数
     */
    private static final DecimalFormat DF = new DecimalFormat("0.00");

    /**
     * MultipartFile转File
     * @param multipartFile
     * @return
     */
    public static File toFile(MultipartFile multipartFile){
        // 获取文件名
        String fileName = multipartFile.getOriginalFilename();
        // 获取文件后缀
        String prefix="."+getExtensionName(fileName);
        File file = null;
        try {
            // 用uuid作为文件名，防止生成的临时文件重复
            file = File.createTempFile(IdUtil.simpleUUID(), prefix);
            // MultipartFile to File
            multipartFile.transferTo(file);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return file;
    }

    /**
     * 删除
     * @param files
     */
    public static void deleteFile(File... files) {
        for (File file : files) {
            if (file.exists()) {
                file.delete();
            }
        }
    }

    /**
     * 获取文件扩展名
     * @param filename
     * @return
     */
    public static String getExtensionName(String filename) {
        if ((filename != null) && (filename.length() > 0)) {
            int dot = filename.lastIndexOf('.');
            if ((dot >-1) && (dot < (filename.length() - 1))) {
                return filename.substring(dot + 1);
            }
        }
        return filename;
    }

    /**
     * Java文件操作 获取不带扩展名的文件名
     * @param filename
     * @return
     */
    public static String getFileNameNoEx(String filename) {
        if ((filename != null) && (filename.length() > 0)) {
            int dot = filename.lastIndexOf('.');
            if ((dot >-1) && (dot < (filename.length()))) {
                return filename.substring(0, dot);
            }
        }
        return filename;
    }

    /**
     * 文件大小转换
     * @param size
     * @return
     */
    public static String getSize(int size){
        String resultSize = "";
        if (size / GB >= 1) {
            //如果当前Byte的值大于等于1GB
            resultSize = DF.format(size / (float) GB) + "GB   ";
        } else if (size / MB >= 1) {
            //如果当前Byte的值大于等于1MB
            resultSize = DF.format(size / (float) MB) + "MB   ";
        } else if (size / KB >= 1) {
            //如果当前Byte的值大于等于1KB
            resultSize = DF.format(size / (float) KB) + "KB   ";
        } else {
            resultSize = size + "B   ";
        }
        return resultSize;
    }

    public static String uploadFile(String uploadPath, MultipartFile file) throws Exception {
        String suffix = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1).toLowerCase();
        if (!Arrays.asList("jpeg,jpg,gif,png,bmp".split(",")).contains(suffix)) {
            throw new BadRequestException("上传文件格式不正确");
        }
        String path = getUploadPath(uploadPath);
        String fileName = upload(path, file, ".jpg");
        commpressPicForScale(path + fileName, path + fileName, 500, 0.8,200,200);
        return fileName;
    }

    public static String uploadPicture(String uploadPath, MultipartFile file) throws Exception {
        String suffix = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1).toLowerCase();
        if (!Arrays.asList("jpeg,jpg,gif,png,bmp".split(",")).contains(suffix)) {
            throw new BadRequestException("上传文件格式不正确");
        }
        String path = getUploadPath(uploadPath);
        String fileName = upload(path, file, ".jpg");
        commpressPicForScale(path + fileName, path + fileName, 1024, 0.8,3000,3000);
        return fileName;
    }

    public static String uploadPictureWithLowCompress(String uploadPath, MultipartFile file) throws Exception {
        String suffix = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1).toLowerCase();
        if (!Arrays.asList("jpeg,jpg,gif,png,bmp".split(",")).contains(suffix)) {
            throw new BadRequestException("上传文件格式不正确");
        }
        String path = getUploadPath(uploadPath);
        String fileName = upload(path, file, ".jpg");
        commpressPicForScale(path + fileName, path + fileName, 2048, 0.8,8000,8000);
        return fileName;
    }

    public static void deleteAvatar(String avatar) {
        String avatarFileName = getRootPath() + avatar;
        log.info("删除->" + avatarFileName);
        if (del(avatarFileName)) {
            log.info("删除成功");
        }
    }

    public static void deletePicture(String picture) {
        if (picture != null) {
            String pictureFileName = getRootPath() + picture;
            log.info("删除->" + pictureFileName);
            if (del(pictureFileName)) {
                log.info("删除成功");
            }
        }
    }

    public static String commpressPicForScale(String srcPath, String desPath,
                                              long desFileSize, double accuracy,int desMaxWidth,int desMaxHeight) {
        if (StringUtils.isEmpty(srcPath) || StringUtils.isEmpty(srcPath)) {
            return null;
        }
        if (!new File(srcPath).exists()) {
            return null;
        }
        try {
            File srcFile = new File(srcPath);
            long srcFileSize = srcFile.length();
            //获取图片信息
            BufferedImage bim = ImageIO.read(srcFile);
            int srcWidth = bim.getWidth();
            int srcHeight = bim.getHeight();

            //先转换成jpg
            Thumbnails.Builder builder = Thumbnails.of(srcFile).outputFormat("jpg");

            // 指定大小（宽或高超出会才会被缩放）
            if(srcWidth > desMaxWidth || srcHeight > desMaxHeight) {
                builder.size(desMaxWidth, desMaxHeight);
            }else{
                //宽高均小，指定原大小
                builder.size(srcWidth,srcHeight);
            }

            // 写入到内存
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            // 字节输出流（写入到内存）
            builder.toOutputStream(baos);

            // 递归压缩，直到目标文件大小小于desFileSize
            byte[] bytes = commpressPicCycle(baos.toByteArray(), desFileSize, accuracy);

            // 输出到文件
            File desFile = new File(desPath);
            FileOutputStream fos = new FileOutputStream(desFile);
            fos.write(bytes);
            fos.close();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return desPath;
    }

    private static byte[] commpressPicCycle(byte[] bytes, long desFileSize, double accuracy) throws IOException {
        // File srcFileJPG = new File(desPath);
        long srcFileSizeJPG = bytes.length;
        // 2、判断大小，如果小于500kb，不压缩；如果大于等于500kb，压缩
        if (srcFileSizeJPG <= desFileSize * 1024) {
            return bytes;
        }
        // 计算宽高
        BufferedImage bim = ImageIO.read(new ByteArrayInputStream(bytes));
        int srcWdith = bim.getWidth();
        int srcHeigth = bim.getHeight();
        int desWidth = new BigDecimal(srcWdith).multiply(
                new BigDecimal(accuracy)).intValue();
        int desHeight = new BigDecimal(srcHeigth).multiply(
                new BigDecimal(accuracy)).intValue();

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        // 字节输出流（写入到内存）
        Thumbnails.of(new ByteArrayInputStream(bytes)).size(desWidth, desHeight).outputQuality(accuracy).toOutputStream(baos);
        return commpressPicCycle(baos.toByteArray(), desFileSize, accuracy);
    }


    /**
     * 获取文件上传路径
     */
    public static String getUploadPath(String path) {
        return System.getProperty("user.dir") + System.getProperty("file.separator") + path + System.getProperty("file.separator");
    }

    public static String getRootPath() {
        return System.getProperty("user.dir");
    }


    public static final String upload(String baseDir, MultipartFile file, String extension) throws FileUploadBase.FileSizeLimitExceededException, IOException {

        int fileNamelength = file.getOriginalFilename().length();
        if (fileNamelength > 200) {
            throw new BadRequestException("文件名太长");
        }

        assertAllowed(file);

        String fileName = encodingFilename(file.getOriginalFilename(), extension);

        File desc = getAbsoluteFile(baseDir, baseDir + fileName);
        file.transferTo(desc);
        return fileName;
    }

    private static final File getAbsoluteFile(String uploadDir, String filename) throws IOException {
        File desc = new File(File.separator + filename);

        if (!desc.getParentFile().exists()) {
            desc.getParentFile().mkdirs();
        }
        if (!desc.exists()) {
            desc.createNewFile();
        }
        return desc;
    }

    public static void assertAllowed(MultipartFile file) throws FileUploadBase.FileSizeLimitExceededException {
        long size = file.getSize();
        if (size > DEFAULT_MAX_SIZE) {
            throw new FileUploadBase.FileSizeLimitExceededException("上传文件大小超过限制", size, DEFAULT_MAX_SIZE);
        }
    }

    /**
     * 编码文件名
     */
    private static String encodingFilename(String filename, String extension) {
        filename = filename.replace("_", " ");
        String mix = hash(filename + System.nanoTime() + counter++);
        filename = generateTimeStampSN() + mix.substring(mix.length() - 5) + extension;
        return filename;
    }

    public static String hash(String s) {
        try {
            return new String(toHex(md5(s)).getBytes("UTF-8"), "UTF-8");
        } catch (Exception e) {
            return s;
        }
    }

    public static String generateTimeStampSN() {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd-HHmmssSSS");
        String timeStampStr = simpleDateFormat.format(new Date());
        return timeStampStr;
    }
}
