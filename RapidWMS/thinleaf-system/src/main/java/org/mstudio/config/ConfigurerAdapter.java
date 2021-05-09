package org.mstudio.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import static org.mstudio.utils.FileUtil.getUploadPath;

/**
 * WebMvcConfigurer
 *
 *
 * @date 2018-11-30
 */
@Configuration
@EnableWebMvc
public class ConfigurerAdapter implements WebMvcConfigurer {

    @Value("${upload.avatar}")
    private String avatarPath;

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowCredentials(true)
                .allowedHeaders("*")
                .allowedOrigins("*")
                .allowedMethods("GET","POST","PUT","DELETE");
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/**").addResourceLocations("classpath:/META-INF/resources/").setCachePeriod(0);
        registry.addResourceHandler("/picture/**").addResourceLocations("file:" + getUploadPath("picture"));
        registry.addResourceHandler("/avatar/**").addResourceLocations("file:" + getUploadPath(avatarPath));
        registry.addResourceHandler("/uploads/**").addResourceLocations("file:" + getUploadPath("uploads"));
        registry.addResourceHandler("/template/**").addResourceLocations("file:" + getUploadPath("template"));
    }
}
