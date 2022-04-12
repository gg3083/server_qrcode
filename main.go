package main

import (
	"fmt"
	"log"
	"net"
	"net/http"
	"os"
	"strings"
)
import "github.com/gin-gonic/gin"

func main() {
	port := os.Args[1:]
	log.Printf("当前运行参数 %s", port)
	// 1.创建路由
	r := gin.Default()
	r.GET("/", func(c *gin.Context) {
		addrs, err := net.InterfaceAddrs()
		if err != nil {
			fmt.Println(err)
			return
		}
		var ips []string
		for _, address := range addrs {
			// 检查ip地址判断是否回环地址
			if ipnet, ok := address.(*net.IPNet); ok && !ipnet.IP.IsLoopback() {
				if ipnet.IP.To4() != nil {
					//fmt.Println(ipnet.IP.String())
					ips = append(ips, ipnet.IP.String())
				}
			}
		}
		c.String(http.StatusOK, strings.Join(ips, ","))
	})
	r.Run(fmt.Sprintf(":%s", port[0]))
}
